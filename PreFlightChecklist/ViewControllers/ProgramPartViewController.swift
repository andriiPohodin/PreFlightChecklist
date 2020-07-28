//
//  ProgramPartViewController.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 21.07.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

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
        
        setUpElements()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "toLesson":
            let destinationVC = segue.destination as? FinalViewController
            if tappedBtn == indoorBtn {
                destinationVC?.lessonToShow = indoorPart
            }
            else if tappedBtn == outdoorBtn {
                destinationVC?.lessonToShow = outdoorPart
            }
            else { return }
        default: break
        }
    }
    
    func setUpElements() {
        
        indoorBtn.setTitle("indoorBtnTitle".localized, for: .normal)
        indoorLabel.text = "indoorLabelText".localized
        outdoorBtn.setTitle("outdoorBtnTitle".localized, for: .normal)
        outdoorLabel.text = "outdoorLabelText".localized
    }
    
    @IBAction func indoorBtnAction(_ sender: UIButton) {
        
        tappedBtn = indoorBtn
        performSegue(withIdentifier: "toLesson", sender: nil)
    }
    @IBAction func outdoorBtnAction(_ sender: UIButton) {
        
        tappedBtn = outdoorBtn
        performSegue(withIdentifier: "toLesson", sender: nil)
    }
}
