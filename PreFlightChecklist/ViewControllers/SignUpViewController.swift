import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var organizationTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
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
            if passwordTextField.isFirstResponder {
                view.frame.origin.y = -passwordTextField.frame.height
            }
            else if confirmPasswordTextField.isFirstResponder {
                view.frame.origin.y = -confirmPasswordTextField.frame.height*2
            }
            else if organizationTextField.isFirstResponder {
                view.frame.origin.y = -organizationTextField.frame.height*3
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
        
        errorLabel.alpha = 0
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
    
    func showError (_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    private func validateFields() {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            organizationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showError("fillInAllFields".localized)
        }
        else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let confirmPassword = confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let organization = organizationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if Utilities.isPasswordValid(password) == true {
                if password == confirmPassword {
                    Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, err) in
                        if err != nil {
                            let localizedErr = err?.localizedDescription
                            self?.showError(localizedErr!.localized)
                        }
                        else {
                            let db = Firestore.firestore()
                            db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "organization":organization, "uid":result!.user.uid]) { [weak self] (err) in
                                if err != nil {
                                    self?.showError(err!.localizedDescription)
                                }
                            }
                            Settings.setUserName(firstName)
                            Settings.goToMainVC()
                        }
                    }
                }
                else {
                    showError("passwordConfirmationError".localized)
                }
            }
            else {
                showError("passwordValidationError".localized)
            }
        }
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        
        validateFields()
    }
}
