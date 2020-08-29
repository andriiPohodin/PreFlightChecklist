import UIKit

class LogOutViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = Settings.defaults.string(forKey: Settings.userName)
    }
    
    @IBAction func action(_ sender: UIButton) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: Constants.Storyboard.firstVC) as? FirstViewController
            else { return }
        navigationController?.pushViewController(vc, animated: true)
        Settings.userDidLogOut()
    }
}
