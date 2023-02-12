import UIKit

@MainActor
class ShoppingCoordinator {
    private weak var navigationController: UINavigationController?

    static let shared: ShoppingCoordinator = .init()

    func setNavigation(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    private let storyboard: UIStoryboard = .init(name: "Main", bundle: nil)

    func detail(model: Product) {
        let controller: DetailViewController = storyboard.instantiateViewController(identifier: "DetailViewController")
        controller.presenter = DetailPresenter(model: model)
        navigationController?.pushViewController(controller, animated: true)
    }
}
