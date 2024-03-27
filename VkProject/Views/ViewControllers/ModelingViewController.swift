import UIKit
import ReSwift

class ModelingViewController: UIViewController, StoreSubscriber, Coordinating {
    
    // MARK: - Properties
    var modelingView: ModelingView { return self.view as! ModelingView }
    var groupSize: Int?
    var infectionFactor: Int?
    var timer: Int?
    var valuesForCell = [People]()
    var illnes: Int?
    var coordinator: ModelingCoordinator?

    var pinchGesture: UIPinchGestureRecognizer!
    var zoomLevel: CGFloat = ZoomLevelValues.baseValue.rawValue
    
    var panInitialIndexPath: IndexPath?
    var isSwipeActivated = false
    var isLeftSwipe = false

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func loadView() {
        self.view = ModelingView(frame: UIScreen.main.bounds)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }

    // MARK: - Setup
    private func configView() {
        modelingView.collectionView.allowsMultipleSelection = true
        view.backgroundColor = .background
        modelingView.collectionView.dataSource = self
        modelingView.collectionView.delegate = self

        modelingView.collectionView.register(CellModeling.self, forCellWithReuseIdentifier: "\(CellModeling.self)")
        getState()
        
        modelingView.customizeProgressViewColors()

        modelingView.healthyAmountLabel.text = "\(groupSize ?? 0)"
        modelingView.illAmountLabel.text = "\(0)"

        pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        modelingView.collectionView.addGestureRecognizer(pinchGesture)
        
        let leftSwipeGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleLeftSwipe(_:)))
        leftSwipeGestureRecognizer.delegate = self
        modelingView.collectionView.addGestureRecognizer(leftSwipeGestureRecognizer)

        let rightSwipeGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleRightSwipe(_:)))
        rightSwipeGestureRecognizer.delegate = self
        modelingView.collectionView.addGestureRecognizer(rightSwipeGestureRecognizer)

        let backButton = UIBarButtonItem(title: NameValues.backButtonValue.rawValue, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
    }

    //MARK: - Value From State
    private func getState() {
        let currentState = mainStore.state.modelingParametrsState

        groupSize = currentState.valueGroupSize
        infectionFactor = currentState.infectionFactor
        timer = currentState.time
    }

    // MARK: - New State
    func newState(state: AppState) {
        if !state.peopleIlnessState.people.isEmpty {
            valuesForCell = state.peopleIlnessState.people
            illnes = state.peopleIlnessState.infectionCount
            let allPeople = state.modelingParametrsState.valueGroupSize
            
            DispatchQueue.main.async { [weak self] in
                let valueInfect = Float(mainStore.state.peopleIlnessState.infectionCount)
                let valueAllPeople = Float(mainStore.state.modelingParametrsState.valueGroupSize)
                let valueFinalProgressView = valueInfect / valueAllPeople
                
                self?.modelingView.updateProgress(valueFinalProgressView)
                self?.modelingView.updateIllnesCount(allPeople: allPeople, value: state.peopleIlnessState.infectionCount)
                self?.modelingView.collectionView.reloadData()
            }
        }
    }

    // MARK: - Navigating
    @objc func backButtonTapped() {
        mainStore.dispatch(ClearStateForModellingAction())
        coordinator?.didFinish()
    }
}

// MARK: - Zoom
extension ModelingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CellSizeValues.width.rawValue / zoomLevel
        let height = CellSizeValues.height.rawValue / zoomLevel

        return CGSize(width: width, height: height)
    }

    // MARK: - Gesture Recognizer
    @objc func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }

        if gestureRecognizer.state == .changed {
            let newZoomLevel = zoomLevel * gestureRecognizer.scale
            gestureRecognizer.scale = ZoomLevelValues.gestureRecoginzerScale.rawValue
            
            updateZoomLevel(zoomLevel: newZoomLevel)
        }
    }

    // MARK: - Zoom Level Update
    func updateZoomLevel(zoomLevel: CGFloat) {
        self.zoomLevel = min(max(zoomLevel, ZoomLevelValues.minValue.rawValue), ZoomLevelValues.maxValue.rawValue)
        
        modelingView.updateCells(zoomValue: zoomLevel)
        modelingView.collectionView.reloadData()
    }
}

// MARK: - Collection View Data Source
extension ModelingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupSize ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CellModeling.self)", for: indexPath) as! CellModeling

        //MARK: - setup view for cell
        cell.updateContent(with: valuesForCell[indexPath.item], zoomLevel: self.zoomLevel)

        return cell
    }
}

extension ModelingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let infectAction = InfectPersonAction(index: indexPath.item)
        mainStore.dispatch(infectAction)
    }
}

// MARK: UIGestureRecognizerDelegate
extension ModelingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func handleLeftSwipe(_ gestureRecognizer: UIPanGestureRecognizer) {
        handleSwipe(gestureRecognizer, isLeft: true)
    }

    @objc func handleRightSwipe(_ gestureRecognizer: UIPanGestureRecognizer) {
        handleSwipe(gestureRecognizer, isLeft: false)
    }

    func handleSwipe(_ gestureRecognizer: UIPanGestureRecognizer, isLeft: Bool) {
        switch gestureRecognizer.state {
        case .began:
            let translation = gestureRecognizer.translation(in: modelingView.collectionView)
            if abs(translation.x) > abs(translation.y) {
                isSwipeActivated = true
                isLeftSwipe = isLeft
                panInitialIndexPath = indexPathForItem(at: gestureRecognizer.location(in: modelingView.collectionView))
                // Отключаем прокрутку, когда пользователь начинает свайп
                modelingView.collectionView.isScrollEnabled = false
            }
        case .changed:
            guard isSwipeActivated else { return }
            let currentLocation = gestureRecognizer.location(in: modelingView.collectionView)
            if let indexPath = indexPathForItem(at: currentLocation),
               let initialIndexPath = panInitialIndexPath,
               let cellFrame = modelingView.collectionView.layoutAttributesForItem(at: indexPath)?.frame {
                // Увеличиваем зону распознавания свайпа
                let expandedFrame = cellFrame.insetBy(dx: -30, dy: -30)
                if expandedFrame.contains(currentLocation) {
                    selectCells(from: initialIndexPath, to: indexPath)
                }
            }
        default:
            isSwipeActivated = false
            panInitialIndexPath = nil
            // Включаем прокрутку обратно при завершении жеста
            modelingView.collectionView.isScrollEnabled = true
        }
    }

    func selectCells(from indexPath1: IndexPath, to indexPath2: IndexPath) {
        let minRow = min(indexPath1.row, indexPath2.row)
        let maxRow = max(indexPath1.row, indexPath2.row)
        let minSection = min(indexPath1.section, indexPath2.section)
        let maxSection = max(indexPath1.section, indexPath2.section)

        for section in minSection...maxSection {
            for row in minRow...maxRow {
                let indexPath = IndexPath(row: row, section: section)
                modelingView.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                
                let infectAction = InfectPersonAction(index: indexPath.item)
                mainStore.dispatch(infectAction)
            }
        }
    }

    func indexPathForItem(at point: CGPoint) -> IndexPath? {
        for indexPath in modelingView.collectionView.indexPathsForVisibleItems {
            if let cellFrame = modelingView.collectionView.layoutAttributesForItem(at: indexPath)?.frame {
                if cellFrame.contains(point) {
                    return indexPath
                }
            }
        }
        return nil
    }


}

fileprivate enum NameValues: String {
    case backButtonValue = "Назад"
}

fileprivate enum ZoomLevelValues: CGFloat {
    case maxValue = 11.0
    case minValue = 4.0
    case baseValue = 6.0
    case gestureRecoginzerScale = 1.0
}

fileprivate enum CellSizeValues: CGFloat {
    case width = 400
    case height = 450
}
