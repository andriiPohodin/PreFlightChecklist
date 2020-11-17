import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import ProgressHUD

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    private func setUpElements() {
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(logInBtn)
        forgotPasswordBtn.setTitle("Forgot password?", for: .normal)
        logInBtn.setTitle("logIn".localized, for: .normal)
        emailTextField.placeholder = "email".localized
        emailTextField.becomeFirstResponder()
        passwordTextField.placeholder = "password".localized
        navigationController?.isNavigationBarHidden = false
    }
    
    private func getUserData() {
        
        let docRef = Firestore.firestore().collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "")
        docRef.getDocuments { (snapshot, err) in
            if err != nil {
                print(err!.localizedDescription)
            }
            else {
                let document = snapshot!.documents.first
                let data = document?.data()
                guard let firstName = data?["firstName"] else { return }
                guard let localUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(Auth.auth().currentUser!.uid) else { return }
                let storageRef = Storage.storage().reference(forURL: Constants.storageRef).child(Auth.auth().currentUser!.uid)
                UserSettings.setUserData(firstName as! String, Auth.auth().currentUser!.uid)
                let downloadTask = storageRef.write(toFile: localUrl) { (url, err) in
                    if err != nil {
                        print(err!.localizedDescription)
                    }
                }
                downloadTask.observe(.success) { (snapshot) in
                    print("Image successfuly downloaded")
                }
            }
        }
    }
    
    private func validateFields() {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            ProgressHUD.showError("fillInAllFields".localized)
        }
        else {
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            ProgressHUD.show()
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, err) in
                if err != nil {
                    let localizedErr = err?.localizedDescription
                    ProgressHUD.showError(localizedErr!.localized)
                }
                else {
                    self?.getUserData()
                    ProgressHUD.dismiss()
                    UserSettings.goToMainVC()
                }
            }
        }
    }
    
    @IBAction func logInBtnAction(_ sender: UIButton) {
        
        validateFields()
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        
    }
}

extension LogInViewController: UITextFieldDelegate {
    
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
}
