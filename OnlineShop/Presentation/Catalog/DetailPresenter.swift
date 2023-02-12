class DetailPresenter {
    private weak var view: DetailViewController?
    private var model: Product!

    init(model: Product) {
        self.model = model
    }

    func setView(_ view: DetailViewController) {
        self.view = view
    }

    func show() {
        view?.show(description: model.description)
        view?.navigationItem.title = model.name
    }
}
