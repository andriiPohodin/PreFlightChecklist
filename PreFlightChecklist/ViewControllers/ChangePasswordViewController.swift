import UIKit
import ProgressHUD
import FirebaseAuth

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
    }
    
    func setUpElements() {
        
        newPasswordTextField.placeholder = "New password".localized
        confirmNewPasswordTextField.placeholder = "Confirm new password".localized
        Utilities.styleFilledButton(saveBtn)
        saveBtn.setTitle("save".localized, for: .normal)
        navigationController?.isNavigationBarHidden = false
    }
    
    func changePassword(password: String) {
        
        Auth.auth().currentUser?.updatePassword(to: newPasswordTextField.text!, completion: { (err) in
            if err != nil {
                ProgressHUD.showError(err!.localizedDescription)
                print(err!.localizedDescription)
            }
        })
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        
        
        if newPasswordTextField.text == "" || confirmNewPasswordTextField.text == "" {
            ProgressHUD.showError("fillInAllFields".localized)
        }
        else if Utilities.isPasswordValid(newPasswordTextField.text!) {
            if newPasswordTextField.text == confirmNewPasswordTextField.text {
                changePassword(password: newPasswordTextField.text!)
                ProgressHUD.showSuccess("Password changed successfuly!")
                navigationController?.popViewController(animated: true)
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
