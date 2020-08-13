//
//  LogInViewController.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 21.07.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case Constants.Segues.logInToMain:
            let destinationVC = segue.destination as? LogOutViewController
            guard let userName = emailTextField.text
                else { return }
            destinationVC?.userName = userName
        default:
            break
        }
    }
    
    func setUpElements() {
        
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInBtn)
        logInBtn.setTitle("logIn".localized, for: .normal)
        emailTextField.placeholder = "email".localized
        passwordTextField.placeholder = "password".localized
    }
    
    func showError (_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateFields() {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showError("fillInAllFields".localized)
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    let localizedErr = err?.localizedDescription
                    self.showError(localizedErr!.localized)
                }
                else {
                    self.performSegue(withIdentifier: Constants.Segues.logInToMain, sender: nil)
                }
            }
        }
    }
    
    @IBAction func logInBtnAction(_ sender: UIButton) {
        
        validateFields()
    }
}
