import UIKit

class FinalViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var lessonToShow = [ProgramStep]()
    let defaultStep = 1
    var currentStep = Int()
    var maxNumberOfSteps = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
    }
    
    private func setUpElements() {
        
        maxNumberOfSteps = lessonToShow.count
        guard let firstStep = lessonToShow.first(where: { $0.stepNumber == defaultStep }) else { return }
        stepLabel.text = "Step".localized + " \(firstStep.stepNumber)"
        nextBtn.setTitle("nextBtnTitle".localized, for: .normal)
        Utilities.enabledButton(nextBtn)
        previousBtn.setTitle("previousBtnTitle".localized, for: .normal)
        Utilities.disabledButton(previousBtn)
        mainImage.image = UIImage(named: "\(firstStep.stepDescription)".localized)
        currentStep = defaultStep
    }
    
    private func stepForward() {
        
        guard let stepFwd = lessonToShow.first(where: { $0.stepNumber == currentStep + 1 }) else { return }
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
        scrollView.zoomScale = 1
        stepLabel.text = "Step".localized + " \(stepFwd.stepNumber)"
        mainImage.image = UIImage(named: "\(stepFwd.stepDescription)".localized)
        currentStep += 1
    }
    
    private func stepBack() {
        
        guard let stepBack = lessonToShow.first(where: { $0.stepNumber == currentStep - 1 }) else { return }
        scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: false)
        scrollView.zoomScale = 1
        stepLabel.text = "Step".localized + " \(stepBack.stepNumber)"
        mainImage.image = UIImage(named: "\(stepBack.stepDescription)".localized)
        currentStep -= 1
    }
    
    private func nextStepOnScreen() {
        
        switch currentStep {
        case maxNumberOfSteps: break
        case maxNumberOfSteps - 1:
            if maxNumberOfSteps == 2 {
                stepForward()
                Utilities.disabledButton(nextBtn)
                Utilities.enabledButton(previousBtn)
            }
            else {
                stepForward()
                Utilities.disabledButton(nextBtn)
            }
        case defaultStep:
            stepForward()
            Utilities.enabledButton(previousBtn)
        default:
            stepForward()
        }
    }
    
    private func previousStepOnScreen() {
        
        switch currentStep {
        case defaultStep: break
        case defaultStep + 1:
            if maxNumberOfSteps == 2 {
                stepBack()
                Utilities.disabledButton(previousBtn)
                Utilities.enabledButton(nextBtn)
            }
            else {
                stepBack()
                Utilities.disabledButton(previousBtn)
            }
        case maxNumberOfSteps:
            stepBack()
            Utilities.enabledButton(nextBtn)
        default:
            stepBack()
        }
    }
    
    @IBAction func previousBtnAction(_ sender: UIButton) {
        
        previousStepOnScreen()
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        nextStepOnScreen()
    }
    
    @IBAction func swipeAction(_ sender: UISwipeGestureRecognizer) {

        switch sender.direction {
        case .right:
            previousStepOnScreen()
        case .left:
            nextStepOnScreen()
        default: break
        }
    }
}

extension FinalViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return contentView
    }
}
