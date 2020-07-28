//
//  SignUpViewController.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 21.07.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var organizationTextField: UITextField!
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
        Utilities.styleTextField(organizationTextField)
        Utilities.styleFilledButton(signUpBtn)
        signUpBtn.setTitle("signUp".localized, for: .normal)
        firstNameTextField.placeholder = "firstName".localized
        lastNameTextField.placeholder = "lastName".localized
        emailTextField.placeholder = "email".localized
        passwordTextField.placeholder = "password".localized
        organizationTextField.placeholder = "organization".localized
    }
    
    func showError (_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateFields() {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || organizationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showError("fillInAllFields".localized)
        }
        else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let organization = organizationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError(err!.localizedDescription)
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "organization":organization, "uid":result!.user.uid]) { (err) in
                        if err != nil {
                            self.showError("Error saving to database")
                        }
                    }
                    self.transitionToHomeScreen()
                }
            }
        }
    }
    
    func transitionToHomeScreen() {
        let mainVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController) as? MainViewController
        view.window?.rootViewController = mainVC
        view.window?.makeKeyAndVisible()
    }

    @IBAction func signUpBtnAction(_ sender: UIButton) {
        
        validateFields()
        
    }
}
