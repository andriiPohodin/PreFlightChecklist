//
//  ViewController.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 21.07.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
    }
    
    func setUpElements() {
        Utilities.styleFilledButton(signUpBtn)
        Utilities.styleHollowButton(logInBtn)
        signUpBtn.setTitle("signUp".localized, for: .normal)
        logInBtn.setTitle("logIn".localized, for: .normal)
    }
}

