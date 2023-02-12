import UIKit

@MainActor
class MainTabBarCoordinator {
    weak var tabBarController: UITabBarController?
    weak var navigationController: UINavigationController!

    func start() -> UIViewController {
        let tabBarController = UITabBarController()
        self.tabBarController = tabBarController
        tabBarController.viewControllers = [
            shopping(),
            profile(),
        ]
        return tabBarController
    }

    private let storyboard: UIStoryboard = .init(name: "Main", bundle: nil)

    func showDetail(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        let vc = DetailViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    private func shopping() -> UIViewController {
        let controller: CatalogViewController = storyboard.instantiateViewController(identifier: "CatalogViewController")
        controller.tabBarItem = .init(
            title: "Catalog",
            image: .init(systemName: "cart"),
            selectedImage: .init(systemName: "cart.fill")
        )
        
        let presenter = CatalogPresenter()
        presenter.coordinator = ShoppingCoordinator.shared
        controller.presenter = presenter
        let navController = UINavigationController(rootViewController: controller)
        return navController
    }

    private func profile() -> UIViewController {
        let controller: ProfileViewController = storyboard.instantiateViewController(identifier: "ProfileViewController")
        controller.tabBarItem = .init(
            title: "Profile",
            image: .init(systemName: "person.circle"),
            selectedImage: .init(systemName: "person.circle.fill")
        )
        return controller
    }
}
