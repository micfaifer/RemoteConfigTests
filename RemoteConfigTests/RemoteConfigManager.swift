import Firebase

class RemoteConfigManager {
    enum ValueKey: String {
        case labelText
    }
    
    let appDefaults: [String:NSObject] = [
        ValueKey.labelText.rawValue : "Olá" as NSObject
    ]
    
    private let remoteConfig: RemoteConfig
    private var expirationDuration: Int

    static let sharedInstance = RemoteConfigManager()
    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.setDefaults(appDefaults)
        
        #if DEBUG
        expirationDuration = 60
        #else
        expirationDuration = 43200 // 12h
        #endif
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchConfig), name: .init("stale"), object: nil)
    }
    
    @objc func fetchConfig(_ completionHandler: ((_ error: Error?) -> Void)?) {
        if UserDefaults.standard.bool(forKey: "CONFIG_STALE") {
            expirationDuration = 0
            UserDefaults.standard.setValue(false, forKey: "CONFIG_STALE")
        }
        
        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) in
            if status == .success {
                self.remoteConfig.activate(completion: nil)
                completionHandler?(nil)
            } else {
                completionHandler?(error)
            }
        }
    }
    
    func getLabelText() -> String {
        return remoteConfig[ValueKey.labelText.rawValue].stringValue!
    }
}
