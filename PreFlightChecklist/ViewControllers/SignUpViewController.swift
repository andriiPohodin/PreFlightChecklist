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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
        navigationController?.isNavigationBarHidden = false
    }
    
    func goToMainVC() {

        guard let tabBar = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarVC) as? UITabBarController
            else { return }
        navigationController?.pushViewController(tabBar, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let firstResponder = view.window?.firstResponder
        firstResponder!.resignFirstResponder()
        return true
    }
    
    func setUpElements() {
        
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
        lastNameTextField.placeholder = "lastName".localized
        emailTextField.placeholder = "email".localized
        passwordTextField.placeholder = "password".localized
        confirmPasswordTextField.placeholder = "confirmPassword".localized
        organizationTextField.placeholder = "organization".localized
    }
    
    func showError (_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func validateFields() {
        
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
            let confirmPassword = confirmPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
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
                            db.collection("users").addDocument(data: ["firstName":firstName, "lastName":lastName, "organization":organization, "uid":result!.user.uid]) { (err) in
                                if err != nil {
                                    self?.showError(err!.localizedDescription)
                                }
                            }
                            Settings.userDidLogIn((self?.emailTextField.text)!)
                            self?.goToMainVC()
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
