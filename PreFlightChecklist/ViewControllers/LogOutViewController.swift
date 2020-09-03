import UIKit

class LogOutViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = Settings.defaults.string(forKey: Settings.userName)
    }
    
    @IBAction func action(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
            Settings.userDidLogOut()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        present(alertVC, animated: true, completion: nil)
    }
}
