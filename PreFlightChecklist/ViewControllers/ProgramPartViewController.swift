import UIKit

class ProgramPartViewController: UIViewController {
    
    @IBOutlet weak var indoorBtn: UIButton!
    @IBOutlet weak var indoorLabel: UILabel!
    @IBOutlet weak var outdoorBtn: UIButton!
    @IBOutlet weak var outdoorLabel: UILabel!
    
    var indoorPart = [ProgramStep]()
    var outdoorPart = [ProgramStep]()
    var tappedBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case Constants.Segues.toLesson:
            let destinationVC = segue.destination as? FinalViewController
            if tappedBtn == indoorBtn {
                destinationVC?.lessonToShow = indoorPart
            }
            else if tappedBtn == outdoorBtn {
                destinationVC?.lessonToShow = outdoorPart
            }
            else { return }
        default:
            break
        }
    }
    
    private func setUpElements() {
        
        indoorBtn.setTitle("indoorBtnTitle".localized, for: .normal)
        indoorLabel.text = "indoorLabelText".localized
        outdoorBtn.setTitle("outdoorBtnTitle".localized, for: .normal)
        outdoorLabel.text = "outdoorLabelText".localized
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func indoorBtnAction(_ sender: UIButton) {
        
        tappedBtn = indoorBtn
        performSegue(withIdentifier: Constants.Segues.toLesson, sender: nil)
    }
    @IBAction func outdoorBtnAction(_ sender: UIButton) {
        
        tappedBtn = outdoorBtn
        performSegue(withIdentifier: Constants.Segues.toLesson, sender: nil)
    }
}
