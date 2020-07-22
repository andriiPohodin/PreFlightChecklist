//
//  SignUpViewController.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 21.07.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

    }

    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpBtn)
        signUpBtn.setTitle("signUp".localized, for: .normal)
        firstNameTextField.placeholder = "firstName".localized
        lastNameTextField.placeholder = "lastName".localized
        emailTextField.placeholder = "email".localized
        passwordTextField.placeholder = "password".localized
    }

    @IBAction func signUpBtnAction(_ sender: UIButton) {
    }
}
