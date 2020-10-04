import Firebase

class RCValues {
    enum ValueKey: String {
      case labelText
    }
    
    let appDefaults: [String:NSObject] = [
      ValueKey.labelText.rawValue : "Olá" as NSObject
    ]
    
    private let remoteConfig: RemoteConfig
    static let sharedInstance = RCValues()
    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.setDefaults(appDefaults)
        remoteConfig.configSettings.minimumFetchInterval = 7200
        if remoteConfig.configSettings.isDeveloperModeEnabled || UserDefaults.standard.bool(forKey: "CONFIG_STALE") {
            remoteConfig.configSettings.minimumFetchInterval = 7200
        }
    }
    
    func fetchRemoteConfig(_ completionHandler: @escaping ((_ error: Error?) -> Void)) {
        remoteConfig.fetch { status, error in
            return completionHandler(error)
        }
    }
    
    func getLabelText() -> String {
        return remoteConfig[ValueKey.labelText.rawValue].stringValue!
    }
}
