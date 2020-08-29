import UIKit

class Settings {
    
    static let defaults = UserDefaults.standard
    static let userName = "user"
    
    static func userDidLogIn(_ user:String) {
        defaults.set(user, forKey: userName)
    }
    
    static func userDidLogOut() {
        defaults.removeObject(forKey: userName)
    }
    
}
