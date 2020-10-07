import UIKit

class UserSettings {
    
    static let defaults = UserDefaults.standard
    static let userName = "user"
    static let currentUserUid = "currentUserUid"
    
    static func setUserData(_ name:String, uid:String) {
        
        defaults.setValue(name, forKey: userName)
        defaults.setValue(uid, forKey: currentUserUid)
    }
    
    static func removeUserData() {
        
        defaults.removeObject(forKey: userName)
        defaults.removeObject(forKey: currentUserUid)
    }
    
    static func ifLoggedIn() {
        
        if UserSettings.defaults.value(forKey: UserSettings.userName) != nil {
            goToMainVC()
        }
        else if UserSettings.defaults.value(forKey: UserSettings.userName) == nil {
            goToFirstVC()
        }
    }
    
    static func goToMainVC() {
        
        guard let vc = UIStoryboard(name: Constants.Storyboard.main, bundle: Bundle.main).instantiateInitialViewController() else { return }
        UIApplication.shared.windows.first?.rootViewController = vc
    }
    
    static func goToFirstVC() {
        
        removeUserData()
        guard let vc = UIStoryboard(name: Constants.Storyboard.logIn, bundle: Bundle.main).instantiateInitialViewController() else { return }
        UIApplication.shared.windows.first?.rootViewController = vc
    }
}
