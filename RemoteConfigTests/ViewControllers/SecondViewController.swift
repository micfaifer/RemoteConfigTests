import UIKit

class SecondViewController: UIViewController {
    let labelTestekey = "labelText"
    let newButtonFeature = "newButton"
    
    @IBOutlet weak var labelWelcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelWelcome.text = RemoteConfigManager.sharedInstance.getLabelText()
    }
}

