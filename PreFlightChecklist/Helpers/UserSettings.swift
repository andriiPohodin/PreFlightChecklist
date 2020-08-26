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
    static let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    static func userDidLogIn(_ userName:String) {
        defaults.set(userName, forKey: "userName")
    }
    
    static func userDidLogOut() {
        defaults.set("", forKey: "userName")
    }
    
    static func ifUserLogedIn() {
        if defaults.string(forKey: "userName") == "" {
            showFirstVC()
        }
        else {
            showMainVC()
        }
    }
    
    static func showMainVC() {
        guard let vc = storyBoard.instantiateViewController(identifier: Constants.Storyboard.firstVC) as? MainViewController
            else { return }
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = .fullScreen
        vc.present(navigationVC, animated: false)
    }
    
    static func showFirstVC() {
        guard let vc = storyBoard.instantiateViewController(identifier: Constants.Storyboard.firstVC) as? FirstViewController
            else { return }
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = .fullScreen
        vc.present(navigationVC, animated: false)
    }
}
