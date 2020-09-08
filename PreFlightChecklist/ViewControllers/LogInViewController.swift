import UIKit
import FirebaseAuth
import Firebase

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
        navigationController?.isNavigationBarHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func goToMainVC() {
        
        guard let tabBar = storyboard?.instantiateViewController(identifier: Constants.Storyboard.tabBarVC) as? UITabBarController
            else { return }
        navigationController?.pushViewController(tabBar, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            validateFields()
        default: break
        }
        return true
    }
    
    func setUpElements() {
        
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInBtn)
        logInBtn.setTitle("logIn".localized, for: .normal)
        emailTextField.placeholder = "email".localized
        emailTextField.becomeFirstResponder()
        passwordTextField.placeholder = "password".localized
    }
    
    func showError (_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    private func getUserName() {
        
        let docRef = Firestore.firestore().collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "")
        docRef.getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            else {
                let document = querySnapshot!.documents.first
                let dataDescription = document?.data()
                guard let firstName = dataDescription?["firstName"] else { return }
                Settings.defaults.set(firstName, forKey: Settings.userName)
//                print(firstname)
            }
        }
    }
    
    func validateFields() {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showError("fillInAllFields".localized)
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, err) in
                if err != nil {
                    let localizedErr = err?.localizedDescription
                    self?.showError(localizedErr!.localized)
                }
                else {
                    Settings.didLogIn(true)
                    self?.getUserName()
                    self?.goToMainVC()
                }
            }
        }
    }
    
    
    @IBAction func logInBtnAction(_ sender: UIButton) {
        
        validateFields()
    }
}
