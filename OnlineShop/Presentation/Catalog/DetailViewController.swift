import UIKit

class DetailViewController: UIViewController {
    var presenter: DetailPresenter!
    @IBOutlet private var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(self)
        presenter.show()
    }

    func show(description: String) {
        descriptionLabel.text = description
    }
}
