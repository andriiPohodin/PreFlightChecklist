import UIKit

class LogOutViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = Settings.defaults.string(forKey: Settings.userName)
    }
    
    @IBAction func action(_ sender: UIButton) {
        
        navigationController?.popToRootViewController(animated: true)
        Settings.userDidLogOut()
    }
}
