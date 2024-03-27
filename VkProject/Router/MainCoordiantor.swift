import UIKit
import ReSwift

class MainCoordiantor: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainVC = ViewController()
        mainVC.coordinator = self
        navigationController.pushViewController(mainVC, animated: true)
    }
    
    func showModelingView() {
        let modelingCoordinator = ModelingCoordinator(navigationController: navigationController)
        addChildCoordinator(modelingCoordinator)
        modelingCoordinator.start()
    }
    
}

class ModelingCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let modelingVC = ModelingViewController()
        modelingVC.coordinator = self
        navigationController.pushViewController(modelingVC, animated: true)
    }

    func didFinish() {
        navigationController.popViewController(animated: true)
        removeChildCoordinator(self)
    }
}
