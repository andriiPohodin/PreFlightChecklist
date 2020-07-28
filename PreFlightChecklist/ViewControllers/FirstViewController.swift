//
//  ViewController.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 21.07.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit
import AVKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    
    var videoPlayer: AVQueuePlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var playerLooper: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        setUpVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        videoPlayer?.playImmediately(atRate: 2)
    }
    
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpBtn)
        Utilities.styleHollowButton(logInBtn)
        signUpBtn.setTitle("signUp".localized, for: .normal)
        logInBtn.setTitle("logIn".localized, for: .normal)
    }
    
    func setUpVideo() {
        
        guard let bundlePath = Bundle.main.path(forResource: "My Movie", ofType: "mp4")
            else { return }
        let url = URL(fileURLWithPath: bundlePath)
        let item = AVPlayerItem(url: url)
        videoPlayer = AVQueuePlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer?.frame = CGRect (x: -self.view.frame.width * 0.5, y: -self.view.frame.height * 0.58, width: self.view.frame.width * 2, height: self.view.frame.height * 2)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        playerLooper = AVPlayerLooper(player: videoPlayer!, templateItem: item)
        videoPlayer?.playImmediately(atRate: 2)
    }
    @IBAction func signUpAction(_ sender: UIButton) {
        
        videoPlayer?.pause()
    }
    @IBAction func logInACtion(_ sender: UIButton) {
        
        videoPlayer?.pause()
    }
}

