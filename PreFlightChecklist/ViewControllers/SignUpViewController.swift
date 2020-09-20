import UIKit
import FirebaseAuth
import Firebase
import ProgressHUD

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var organizationTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        organizationTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    @objc private func keyboardWillChange(notification: Notification) {
        
        switch notification.name {
        case UIResponder.keyboardDidShowNotification:
            if firstNameTextField.isFirstResponder {
                view.frame.origin.y = 0
            }
            else if lastNameTextField.isFirstResponder {
                view.frame.origin.y = 0
            }
            else if emailTextField.isFirstResponder {
                view.frame.origin.y = -emailTextField.frame.height
            }
            else if passwordTextField.isFirstResponder {
                view.frame.origin.y = -passwordTextField.frame.height*2
            }
            else if confirmPasswordTextField.isFirstResponder {
                view.frame.origin.y = -confirmPasswordTextField.frame.height*2
            }
            else if organizationTextField.isFirstResponder {
                view.frame.origin.y = -organizationTextField.frame.height*2
            }
            else { return }
        case UIResponder.keyboardWillHideNotification:
            view.frame.origin.y = 0
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmPasswordTextField.becomeFirstResponder()
        case confirmPasswordTextField:
            organizationTextField.becomeFirstResponder()
        case organizationTextField:
            organizationTextField.resignFirstResponder()
            validateFields()
        default: break
        }
        return true
    }
    
    private func setUpElements() {
        
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(confirmPasswordTextField)
        Utilities.styleTextField(organizationTextField)
        Utilities.styleFilledButton(signUpBtn)
        signUpBtn.setTitle("signUp".localized, for: .normal)
        firstNameTextField.placeholder = "firstName".localized
        firstNameTextField.becomeFirstResponder()
        lastNameTextField.placeholder = "lastName".localized
        emailTextField.placeholder = "email".localized
        passwordTextField.placeholder = "password".localized
        confirmPasswordTextField.placeholder = "confirmPassword".localized
        organizationTextField.placeholder = "organization".localized
        navigationController?.isNavigationBarHidden = false
    }
    
    private func validateFields() {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            organizationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            ProgressHUD.showError("fillInAllFields".localized)
        }
        else {
            ProgressHUD.show()
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let confirmPassword = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let organization = organizationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if Utilities.isPasswordValid(password) == true {
                if password == confirmPassword {
                    Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                        if err != nil {
                            let localizedErr = err?.localizedDescription
                            ProgressHUD.showError(localizedErr!.localized)
                        }
                        else {
                            let db = Firestore.firestore()
                            db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "organization":organization, "uid":result!.user.uid]) { (err) in
                                if err != nil {
                                    ProgressHUD.showError(err!.localizedDescription)
                                }
                            }
                            Settings.setUserName(firstName)
                            ProgressHUD.dismiss()
                            Settings.goToMainVC()
                        }
                    }
                }
                else {
                    ProgressHUD.showError("passwordConfirmationError".localized)
                }
            }
            else {
                ProgressHUD.showError("passwordValidationError".localized)
            }
        }
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        
        validateFields()
    }
}
