import UIKit

protocol CatalogViewProtocol: AnyObject {
    func redraw()
}

@MainActor
class CatalogViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!

    var presenter: CatalogPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setView(self)
        setupUI()
        configureTableView()
    }

    func showLoader() {
        activityIndicatorView.startAnimating()
    }

    func hideLoader() {
        activityIndicatorView.stopAnimating()
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "productCell")
        Task {
            try await presenter.fetchProducts()
        }
    }
}


extension CatalogViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.productCount
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        presenter.configure(cell: cell, row: indexPath.row)
        return cell
    }
}

extension CatalogViewController: CatalogViewProtocol {
    func redraw() {
        tableView.reloadData()
    }
}

extension CatalogViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nav = navigationController else { return }
        presenter.showDetails(navigation: nav, row: indexPath.row)
    }
}
