import UIKit

@MainActor
class CatalogPresenter {
    private weak var view: CatalogViewController?
    weak var coordinator: ShoppingCoordinator!

    var catalogService: CatalogService = MockCatalogService.shared

    private var model: [Product] = [] {
        didSet {
            view?.redraw()
        }
    }

    var productCount: Int {
        return model.count
    }

    func setView(_ view: CatalogViewController) {
        self.view = view
    }

    func fetchProducts() async throws {
        Task {
            view?.showLoader()
            do {
                model = try await catalogService.fetchProducts()
                view?.hideLoader()
            } catch {
                print(error.localizedDescription)
                view?.hideLoader()
            }
        }
    }

    func configure(cell: UITableViewCell, row: Int) {
        let product = model[row]
        var configuration = UIListContentConfiguration.cell()
        configuration.text = product.name
        cell.contentConfiguration = configuration
    }

    func showDetails(navigation: UINavigationController, row: Int) {
        coordinator.setNavigation(navigation)
        coordinator.detail(model: model[row])
    }
}
