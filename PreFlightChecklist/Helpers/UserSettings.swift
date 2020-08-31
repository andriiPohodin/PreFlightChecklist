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
    
//    static func pushMainVC(_ storyBoard:UIStoryboard?, _ navVC:UINavigationController?, _ tabBarVC:UITabBarController?) {
//        guard let mainStoryBoard = storyBoard
//            else { return }
//        guard let navigationVC = navVC
//            else { return }
//        guard let tabBar = tabBarVC
//            else { return }
//        let mainVC = mainStoryBoard.instantiateViewController(identifier: Constants.Storyboard.mainVC) as MainViewController
//        navigationVC.pushViewController(mainVC, animated: false)
//        navigationVC.pushViewController(tabBar, animated: false)
//    }
    
//    static func pushMainVC() {
//
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let navigationVC = storyBoard.instantiateViewController(identifier: Constants.Storyboard.navVC) as? UINavigationController
//            else { return }
//        guard let tabBarVC = storyBoard.instantiateViewController(identifier: Constants.Storyboard.tabBarVC) as? UITabBarController
//            else { return }
//        guard let mainVC = storyBoard.instantiateViewController(identifier: Constants.Storyboard.mainVC) as? MainViewController
//            else { return }
//        navigationVC.pushViewController(mainVC, animated: false)
//        navigationVC.pushViewController(tabBarVC, animated: false)
//        window.rootViewController = navigationVC
//        window.makeKeyAndVisible()
//    }
    
}
