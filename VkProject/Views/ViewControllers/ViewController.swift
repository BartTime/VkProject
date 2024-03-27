import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {
    
    // MARK: - Properties
    var configView: ConfigView { return self.view as! ConfigView }
    var coordinator: MainCoordiantor?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func loadView() {
        self.view = ConfigView(frame: UIScreen.main.bounds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    // MARK: - New State
    func newState(state: AppState) {
        if state.configureViewState.tapped {
            let action = StartModelingActionTapped(tapped: false, valueGroupSize: "", infetionFactor: "", time: "")
            mainStore.dispatch(action)
            coordinator?.showModelingView()
        }
        
        if let error = state.configureViewState.error {
            presentAllert(error: error.localizeDescription)
            let action = StartModelingActionTapped(tapped: false, valueGroupSize: "", infetionFactor: "", time: "")
            mainStore.dispatch(action)
        }
    }
    
    // MARK: - Setup
    func setup() {
        view.backgroundColor = .background
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        configView.actionButtonTapped = { [weak self] (valueGS, valueIF, valueT) in
            self?.actionButtonTap(valueGroupSize: valueGS, infectionFactor: valueIF, time: valueT)
        }
    }
    
    //MARK: - Hide keyboard
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Touch event
extension ViewController {
    @objc func actionButtonTap(valueGroupSize: String, infectionFactor: String, time: String) {
        let action = StartModelingActionTapped(tapped: true, valueGroupSize: valueGroupSize, infetionFactor: infectionFactor, time: time)
        mainStore.dispatch(action)
    }
}

// MARK: - PresentAlert
extension ViewController {
    func presentAllert(error: String) {
        let allert = configView.presentAllert(message: error)
        present(allert, animated: true, completion: nil)
    }
}
