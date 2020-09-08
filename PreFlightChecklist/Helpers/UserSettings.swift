import UIKit

class Settings {
    
    static let defaults = UserDefaults.standard
    static let userName = "user"
    static let isLoggedIn = "isLoggedIn"
    
    static func getUserName(_ name:String) {
        defaults.set(name, forKey: userName)
    }
    
    static func removeUserName() {
        defaults.removeObject(forKey: userName)
    }
    
    static func didLogIn(_ didLogIn:Bool) {
        defaults.set(didLogIn, forKey: isLoggedIn)
        print(didLogIn)
    }
    
    static func ifLoggedIn(_ window:UIWindow?) {
        let window = window
        if Settings.defaults.bool(forKey: Settings.isLoggedIn) == true {
            guard let navigationVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.Storyboard.navVC) as? UINavigationController
                else { return }
            guard let tabBarVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.Storyboard.tabBarVC) as? UITabBarController
                else { return }
            window?.rootViewController = navigationVC
            navigationVC.pushViewController(tabBarVC, animated: false)
            window?.makeKeyAndVisible()
        }
        else {
            guard let navigationVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.Storyboard.navVC) as? UINavigationController
                else { return }
            window?.rootViewController = navigationVC
            window?.makeKeyAndVisible()
        }
    }
    
//    static func goToMainVC() {
//        guard let navigationVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.Storyboard.navVC) as? UINavigationController
//            else { return }
//        guard let tabBarVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.Storyboard.tabBarVC) as? UITabBarController
//            else { return }
//        navigationVC.pushViewController(tabBarVC, animated: false)
//    }
}
