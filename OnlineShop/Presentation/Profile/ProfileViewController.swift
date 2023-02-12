import UIKit

class ProfileViewController: UIViewController {
    var authorizationService: AuthorizationService
        = MockAuthorizationService.shared

    @IBAction private func signOut() {
        authorizationService.signOut()
    }
}
