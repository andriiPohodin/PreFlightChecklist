//
//  UserSettings.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 26.08.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit

class Settings {
    
    static let defaults = UserDefaults.standard
    
    static func userDidLogIn(_ userName:String) {
        defaults.set(userName, forKey: "userName")
    }
    
    static func userDidLogOut() {
        defaults.removeObject(forKey: "userName")
    }
    
//    static func ifUserLogedIn() {
//        if defaults.value(forKey: "userName") != nil {
//            showMainVC()
//        }
//        else {
//            showFirstVC()
//        }
//    }
    
//    static func showFirstVC() {
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.Storyboard.firstVC)
//        let navigationVC = UINavigationController(rootViewController: vc)
//        let share = UIApplication.shared.delegate as? AppDelegate
//        share?.window?.rootV
        
//        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.Storyboard.firstVC) as? FirstViewController
//        let navigationVC = UINavigationController(rootViewController: vc!)
//        navigationVC.pushViewController(vc!, animated: false)
//        navigationVC.modalPresentationStyle = .fullScreen
//        window.rootViewController = navigationVC
//        window.makeKeyAndVisible()
        
//        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.Storyboard.firstVC) as? FirstViewController
//            else { return }
//        let navigationVC = UINavigationController(rootViewController: vc)
//        navigationVC.modalPresentationStyle = .fullScreen
//        DispatchQueue.main.async {
//            self.present(navigationVC, animated: false)
//        }
//    }
//
    static func showMainVC() {
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let vc = storyboard.instantiateViewController(identifier: Constants.Storyboard.mainVC) as? MainViewController
//            else { return }
//        let navigationVC = UINavigationController(rootViewController: vc)
    }
}
