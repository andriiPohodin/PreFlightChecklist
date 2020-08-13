//
//  LogOutViewController.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 13.08.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {
    
    var userName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func action(_ sender: UIButton) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.firstVC) as? FirstViewController
            else { return }
        let navigationVC = UINavigationController(rootViewController: vc)
        navigationVC.modalPresentationStyle = .fullScreen
        self.present(navigationVC, animated: false)
    }
}
