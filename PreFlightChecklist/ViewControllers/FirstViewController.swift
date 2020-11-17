import UIKit
import AVKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    
    var playerLooper: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpVideo()
        setUpElements()
    }
    
    private func setUpElements() {
        
        Utilities.styleFilledButton(signUpBtn)
        Utilities.styleHollowButton(logInBtn)
        signUpBtn.setTitle("signUp".localized, for: .normal)
        logInBtn.setTitle("logIn".localized, for: .normal)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpVideo() {
        
        guard let bundlePath = Bundle.main.path(forResource: "My Movie", ofType: "mp4") else { return }
        let url = URL(fileURLWithPath: bundlePath)
        let item = AVPlayerItem(url: url)
        let player = AVQueuePlayer(playerItem: item)
        let layer = AVPlayerLayer(player: player)
        layer.frame = videoPlayerView.bounds
        layer.videoGravity = .resizeAspectFill
        videoPlayerView.layer.addSublayer(layer)
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.playImmediately(atRate: 2)

    }

    @IBAction func signUpAction(_ sender: UIButton) {
        
    }
    
    @IBAction func logInAction(_ sender: UIButton) {
        
    }
}

