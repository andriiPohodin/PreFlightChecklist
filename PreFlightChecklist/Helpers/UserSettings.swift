import UIKit

class UserSettings {
    
    static let defaults = UserDefaults.standard
    static let userName = "user"
    static let userAvatar = "avatar"
    
    static func setUserName(_ name:String) {
        
        defaults.set(name, forKey: userName)
    }
    
    static func setUserAvatarID(_ avatarID:String) {
        
        defaults.set(avatarID, forKey: userAvatar)
    }
    
    static func removeUserName() {
        
        defaults.removeObject(forKey: userName)
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
        
        removeUserName()
        guard let vc = UIStoryboard(name: Constants.Storyboard.logIn, bundle: Bundle.main).instantiateInitialViewController() else { return }
        UIApplication.shared.windows.first?.rootViewController = vc
    }
}
