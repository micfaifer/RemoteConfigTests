import Firebase

class RCValues {
    enum ValueKey: String {
      case teste
    }
    
    let appDefaults: [String:NSObject] = [
      ValueKey.teste.rawValue : "Oia la vei" as NSObject
    ]
    
    private let remoteConfig: RemoteConfig
    static let sharedInstance = RCValues()
    
    private init() {
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.setDefaults(appDefaults)
    }
    
    func fetchRemoteConfig(_ completionHandler: @escaping ((_ error: Error?) -> Void)) {
        remoteConfig.fetch { status, error in
            guard error == nil else { return completionHandler(nil)}
            completionHandler(error)
        }
    }
}
