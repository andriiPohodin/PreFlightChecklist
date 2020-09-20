import UIKit
import ProgressHUD
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    private func setUpElements() {
        
        Utilities.styleTextField(emailTextField)
        emailTextField.placeholder = "email".localized
        Utilities.styleFilledButton(resetBtn)
        resetBtn.setTitle("Reset password", for: .normal)
    }
    
    @IBAction func resetBtnAction(_ sender: UIButton) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            ProgressHUD.showError("fillInAllFields".localized)
        }
        else {
            guard let email = emailTextField.text else { return }
            Auth.auth().sendPasswordReset(withEmail: email) { [weak self] (err) in
                if err != nil {
                    ProgressHUD.showError(err!.localizedDescription)
                }
                else {
                    self?.view.endEditing(true)
                    ProgressHUD.showSuccess("Please check your email and follow instructions we've sent you!")
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
