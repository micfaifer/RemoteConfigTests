import UIKit

class FirstViewController: UIViewController {
    let segueIdentifier = "startApp"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        RCValues.sharedInstance.fetchRemoteConfig { [weak self] (error) in
            self?.performSegue(withIdentifier: self?.segueIdentifier ?? "", sender: nil)
        }
    }
}
