import UIKit

protocol Coordinating: AnyObject {
    associatedtype CoordinatorType: Coordinator
    var coordinator: CoordinatorType? { get set }
}

extension Coordinating where Self: UIViewController {
    func setCoordinator(_ coordinator: CoordinatorType) {
        var vc: UIViewController? = self
        while let parent = vc?.parent {
            if let coordinatingParent = parent as? AnyCoordinating {
                coordinatingParent.coordinator = coordinator
                break
            }
            vc = parent
        }
        coordinator.navigationController = navigationController ?? UINavigationController()
    }
}

protocol AnyCoordinating: AnyObject {
    var coordinator: Coordinator? { get set }
}
