import UIKit
import FirebaseFirestore
import FirebaseStorage
import ProgressHUD

class LogOutViewController: UIViewController {
    
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
    }
    
    private func setUpElements() {
        
        label.text = "Welcome, \(UserSettings.defaults.string(forKey: UserSettings.userName) ?? "")"
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        signOutBtn.layer.cornerRadius = signOutBtn.frame.height/2
        signOutBtn.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
    }
    
    @IBAction func signOutAction(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: "Sign out", message: "Are you sure?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            ProgressHUD.show()
            UserSettings.goToFirstVC()
            ProgressHUD.dismiss()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func addPhotoAction(_ sender: UIButton) {
        
    }
}
