import UIKit

class ModelingView: UIView {
    
    // MARK: - UI Elements
    let collectionView: UICollectionView
    let progressView: UIProgressView
    
    private let healthyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = cgFloat.stackSpacing.rawValue
        stackView.alignment = .center
        return stackView
    }()
    
    private let illStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = cgFloat.stackSpacing.rawValue
        stackView.alignment = .center
        return stackView
    }()
    
    private let healthyLabel: UILabel = {
        let label = UILabel()
        label.text = TextForLabel.healthyText.rawValue
        label.font = .ModelingView.label.font
        label.textColor = .black
        return label
    }()
    
    let healthyAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .ModelingView.label.font
        label.textColor = .black
        return label
    }()
    
    private let illLabel: UILabel = {
        let label = UILabel()
        label.text = TextForLabel.illText.rawValue
        label.font = .ModelingView.label.font
        label.textColor = .black
        return label
    }()
    
    let illAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .ModelingView.label.font
        label.textColor = .black
        return label
    }()
    
    // MARK: - UpdateUI
    func updateIllnesCount(allPeople: Int, value: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            UIView.transition(with: illAmountLabel, duration: AnimateTimeInterval.labelTransform.rawValue, options: .transitionCrossDissolve, animations: {
                self.illAmountLabel.text = "\(value)"
            }, completion: nil)
            
            UIView.transition(with: healthyAmountLabel, duration: AnimateTimeInterval.labelTransform.rawValue, options: .transitionCrossDissolve, animations: {
                self.healthyAmountLabel.text = "\(allPeople - value)"
            }, completion: nil)
        }
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        healthyStackView.addArrangedSubview(healthyLabel)
        healthyStackView.addArrangedSubview(healthyAmountLabel)
        
        illStackView.addArrangedSubview(illLabel)
        illStackView.addArrangedSubview(illAmountLabel)
        
        addSubview(healthyStackView)
        addSubview(illStackView)
        addSubview(collectionView)
        addSubview(progressView)
        
        
        healthyStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            healthyStackView.topAnchor.constraint(equalTo: topAnchor, constant: cgFloat.constant90.rawValue),
            healthyStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cgFloat.constant40.rawValue)
        ])
        
        illStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            illStackView.topAnchor.constraint(equalTo: topAnchor, constant: cgFloat.constant90.rawValue),
            illStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: cgFloat.constantMinus20.rawValue)
        ])
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: healthyStackView.bottomAnchor, constant: cgFloat.constant20.rawValue),
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cgFloat.constant20.rawValue),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: cgFloat.constantMinus20.rawValue)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: cgFloat.constant20.rawValue),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        let layout = ModelingView.setupLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.cornerRadius = cgFloat.cornerRadius.rawValue
        collectionView.backgroundColor = .white
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.progress = 0.0
        
        super.init(frame: frame)
        
        let pinchGesture = UIPinchGestureRecognizer(target:self, action: #selector(handlePinchGesture(_:)))
        collectionView.addGestureRecognizer(pinchGesture)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Customize Progress View
    func customizeProgressViewColors() {
        progressView.progressTintColor = .progressViewTintColor
        progressView.trackTintColor = .progressViewTrackColor
    }
    
    // MARK: - Collection View Layout
    private static func setupLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SizeValues.itemSizeWidth.rawValue, height: SizeValues.itemSizeHeight.rawValue)
        layout.minimumLineSpacing = cgFloat.minimumLineSapce.rawValue
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 10, right: 30)
        return layout
    }
    
    // MARK: - Gesture Handler
    @objc private func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard let collectionView = gestureRecognizer.view as? UICollectionView else { return }
        
        switch gestureRecognizer.state {
        case .began, .changed:
            let scale = gestureRecognizer.scale
            let currentTransform = collectionView.transform
            collectionView.transform = currentTransform.scaledBy(x: scale, y: scale)
            gestureRecognizer.scale = cgFloat.gesureRecoginzer.rawValue
        case .ended, .cancelled:
            UIView.animate(withDuration: AnimateTimeInterval.collectionViewTrasform.rawValue) {
                collectionView.transform = .identity
            }
        default:
            break
        }
    }
    
    // MARK: - UpdateUI
    func updateCells(zoomValue: CGFloat) {
        for case let cell as CellModeling in collectionView.visibleCells {
            cell.updateContentForZoomLevel(zoomLevel: zoomValue)
        }
    }
    
    func updateProgress(_ progress: Float) {
        UIView.animate(withDuration: AnimateTimeInterval.progressViewDuration.rawValue) {
            self.progressView.setProgress(progress, animated: true)
        }
    }
    
}

// MARK: - Constants
fileprivate enum TextForLabel: String {
    case healthyText = "Healthy:"
    case illText = "Illnes:"
}

fileprivate enum cgFloat: CGFloat {
    case stackSpacing = 10
    case constant90 = 90
    case constant40 = 40
    case constantMinus20 = -20
    case constant20 = 20
    case cornerRadius = 12
    case minimumLineSapce = 50
    case gesureRecoginzer = 1.0
}

fileprivate enum SizeValues: Int {
    case itemSizeWidth = 60
    case itemSizeHeight = 70
}

fileprivate enum AnimateTimeInterval: TimeInterval {
    case progressViewDuration = 0.5
    case collectionViewTrasform = 0.3
    case labelTransform = 0.4
}
