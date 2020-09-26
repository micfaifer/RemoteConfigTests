import UIKit
import Firebase

class ViewController: UIViewController {
    let labelTestekey = "labelText"
    var remoteConfig: RemoteConfig!
    
    @IBOutlet weak var labelTeste: UILabel!
    
    @IBAction func reloadRemoteConfig(_ sender: Any) {
        fetchConfig()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        fetchConfig()
    }
    
    func fetchConfig() {
        // [START fetch_config_with_callback]
        remoteConfig.fetch() { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate() { (changed, error) in
                    // ...
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            self.display()
        }
        // [END fetch_config_with_callback]
    }
    
    func display() {
        // [START get_config_value]
        var label = remoteConfig[labelTestekey].stringValue
        // [END get_config_value]
        
        labelTeste.text = label
    }
}

