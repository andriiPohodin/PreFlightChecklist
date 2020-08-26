//
//  MainViewController.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 21.07.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit
import iOSDropDown

class MainViewController: UIViewController {
    
    @IBOutlet weak var platformDropDown: DropDown!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var programDropDown: DropDown!
    @IBOutlet weak var nextBtn: UIButton!
    
    var selectedPlatformName = String()
    var selectedProgramName = String()
    
    let platforms = [Platform(platformName: "Phantom 4 Pro V2", availablePrograms: [Program(programName: "Basic", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "basicOneIndoor"), ProgramStep(stepNumber: 2, stepDescription: "basicTwoIndoor")]), Program(programName: "Basic", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "basicOneOutdoor"), ProgramStep(stepNumber: 2, stepDescription: "basicTwoOutdoor"), ProgramStep(stepNumber: 3, stepDescription: "basicThreeOutdoor"), ProgramStep(stepNumber: 4, stepDescription: "basicFourOutdoor"), ProgramStep(stepNumber: 5, stepDescription: "basicFiveOutdoor")]), Program(programName: "Advanced", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "advancedOneIndoor"), ProgramStep(stepNumber: 2, stepDescription: "advancedTwoIndoor"), ProgramStep(stepNumber: 3, stepDescription: "advancedThreeIndoor"), ProgramStep(stepNumber: 4, stepDescription: "advancedFourIndoor")]), Program(programName: "Advanced", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "advancedOneOutdoor"), ProgramStep(stepNumber: 2, stepDescription: "advancedTwoOutdoor"), ProgramStep(stepNumber: 3, stepDescription: "advancedThreeOutdoor"), ProgramStep(stepNumber: 4, stepDescription: "advancedFourOutdoor"), ProgramStep(stepNumber: 5, stepDescription: "advancedFiveOutdoor")]), Program(programName: "Pro", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "proOneIndoor"), ProgramStep(stepNumber: 2, stepDescription: "proTwoIndoor"), ProgramStep(stepNumber: 3, stepDescription: "proThreeIndoor"), ProgramStep(stepNumber: 4, stepDescription: "proFourIndoor"), ProgramStep(stepNumber: 5, stepDescription: "proFiveIndoor")]), Program(programName: "Pro", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "proOneOutdoor"), ProgramStep(stepNumber: 2, stepDescription: "proTwoOutdoor"), ProgramStep(stepNumber: 3, stepDescription: "proThreeOutdoor"), ProgramStep(stepNumber: 4, stepDescription: "proFourOutdoor"), ProgramStep(stepNumber: 5, stepDescription: "proFiveOutdoor"), ProgramStep(stepNumber: 6, stepDescription: "proSixOutdoor")])]),
                     Platform(platformName: "Phantom 4 RTK", availablePrograms: [Program(programName: "Advanced", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "advancedOneIndoorRtk"), ProgramStep(stepNumber: 2, stepDescription: "advancedTwoIndoorRtk"), ProgramStep(stepNumber: 3, stepDescription: "advancedThreeIndoorRtk"), ProgramStep(stepNumber: 4, stepDescription: "advancedFourIndoorRtk")]), Program(programName: "Advanced", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "advancedOneOutdoorRtk"), ProgramStep(stepNumber: 2, stepDescription: "advancedTwoOutdoorRtk"), ProgramStep(stepNumber: 3, stepDescription: "advancedThreeOutdoorRtk"), ProgramStep(stepNumber: 4, stepDescription: "advancedFourOutdoorRtk"), ProgramStep(stepNumber: 5, stepDescription: "advancedFiveOutdoorRtk")]), Program(programName: "Pro", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "proOneIndoorRtk"), ProgramStep(stepNumber: 2, stepDescription: "proTwoIndoorRtk"), ProgramStep(stepNumber: 3, stepDescription: "proThreeIndoorRtk"), ProgramStep(stepNumber: 4, stepDescription: "proFourIndoorRtk"), ProgramStep(stepNumber: 5, stepDescription: "proFiveIndoorRtk")]), Program(programName: "Pro", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "proOneOutdoorRtk"), ProgramStep(stepNumber: 2, stepDescription: "proTwoOutdoorRtk"), ProgramStep(stepNumber: 3, stepDescription: "proThreeOutdoorRtk"), ProgramStep(stepNumber: 4, stepDescription: "proFourOutdoorRtk"), ProgramStep(stepNumber: 5, stepDescription: "proFiveOutdoorRtk"), ProgramStep(stepNumber: 6, stepDescription: "proSixOutdoorRtk")])]),
                     Platform(platformName: "Phantom 4 Multispectral", availablePrograms: [Program(programName: "Advanced", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "advancedOneIndoor"), ProgramStep(stepNumber: 2, stepDescription: "advancedTwoIndoor"), ProgramStep(stepNumber: 3, stepDescription: "advancedThreeIndoor"), ProgramStep(stepNumber: 4, stepDescription: "advancedFourIndoor")]), Program(programName: "Advanced", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "advancedOneOutdoor"), ProgramStep(stepNumber: 2, stepDescription: "advancedTwoOutdoor"), ProgramStep(stepNumber: 3, stepDescription: "advancedThreeOutdoor"), ProgramStep(stepNumber: 4, stepDescription: "advancedFourOutdoor"), ProgramStep(stepNumber: 5, stepDescription: "advancedFiveOutdoor")]), Program(programName: "Pro", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "proOneIndoor"), ProgramStep(stepNumber: 2, stepDescription: "proTwoIndoor"), ProgramStep(stepNumber: 3, stepDescription: "proThreeIndoor"), ProgramStep(stepNumber: 4, stepDescription: "proFourIndoor"), ProgramStep(stepNumber: 5, stepDescription: "proFiveIndoor")]), Program(programName: "Pro", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "proOneOutdoor"), ProgramStep(stepNumber: 2, stepDescription: "proTwoOutdoor"), ProgramStep(stepNumber: 3, stepDescription: "proThreeOutdoor"), ProgramStep(stepNumber: 4, stepDescription: "proFourOutdoor"), ProgramStep(stepNumber: 5, stepDescription: "proFiveOutdoor"), ProgramStep(stepNumber: 6, stepDescription: "proSixOutdoor")])]),
                     Platform(platformName: "Matrice 210 V2 RTK", availablePrograms: [Program(programName: "Advanced", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "advancedOneIndoor"), ProgramStep(stepNumber: 2, stepDescription: "advancedTwoIndoor"), ProgramStep(stepNumber: 3, stepDescription: "advancedThreeIndoor"), ProgramStep(stepNumber: 4, stepDescription: "advancedFourIndoor")]), Program(programName: "Advanced", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "advancedOneOutdoor"), ProgramStep(stepNumber: 2, stepDescription: "advancedTwoOutdoor"), ProgramStep(stepNumber: 3, stepDescription: "advancedThreeOutdoor"), ProgramStep(stepNumber: 4, stepDescription: "advancedFourOutdoor"), ProgramStep(stepNumber: 5, stepDescription: "advancedFiveOutdoor")]), Program(programName: "Pro", isIndoor: true, stepData: [ProgramStep(stepNumber: 1, stepDescription: "proOneIndoor"), ProgramStep(stepNumber: 2, stepDescription: "proTwoIndoor"), ProgramStep(stepNumber: 3, stepDescription: "proThreeIndoor"), ProgramStep(stepNumber: 4, stepDescription: "proFourIndoor"), ProgramStep(stepNumber: 5, stepDescription: "proFiveIndoor")]), Program(programName: "Pro", isIndoor: false, stepData: [ProgramStep(stepNumber: 1, stepDescription: "proOneOutdoor"), ProgramStep(stepNumber: 2, stepDescription: "proTwoOutdoor"), ProgramStep(stepNumber: 3, stepDescription: "proThreeOutdoor"), ProgramStep(stepNumber: 4, stepDescription: "proFourOutdoor"), ProgramStep(stepNumber: 5, stepDescription: "proFiveOutdoor"), ProgramStep(stepNumber: 6, stepDescription: "proSixOutdoor")])])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        getDropDownData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case Constants.Segues.toDetails:
            let destinationVC = segue.destination as? ProgramPartViewController
            let platform = platforms.first(where: { $0.platformName == selectedPlatformName })
            guard let indoorProgram = platform?.availablePrograms.first(where: { $0.programName.localized == selectedProgramName.localized && $0.isIndoor == true })
                else { return }
            destinationVC?.indoorPart = indoorProgram.stepData
            guard let outdoorProgram = platform?.availablePrograms.first(where: { $0.programName.localized == selectedProgramName.localized && $0.isIndoor == false })
                else { return }
            destinationVC?.outdoorPart = outdoorProgram.stepData
        default:
            break
        }
    }
    
    func setUpElements() {
        
        selectedPlatformName = ""
        selectedProgramName = ""
        platformDropDown.text = selectedPlatformName
        programDropDown.text = selectedProgramName
        programDropDown.optionArray = []
        platformDropDown.placeholder = "selectPlatformTitle".localized
        platformDropDown.rowHeight = CGFloat(50)
        platformDropDown.optionArray = platforms.map { $0.platformName }
        platformDropDown.listHeight = CGFloat(50 * platformDropDown.optionArray.count)
        platformDropDown.layer.borderColor = UIColor.red.cgColor
        platformDropDown.selectedRowColor = .white
        mainImage.image = UIImage(named: "defaultImage")
        programDropDown.placeholder = "selectProgramTitle".localized
        programDropDown.rowHeight = CGFloat(50)
        programDropDown.layer.borderColor = UIColor.red.cgColor
        programDropDown.selectedRowColor = .white
        nextBtn.setTitle("nextBtnTitle".localized, for: .normal)
        Utilities.disabledButton(nextBtn)
        nextBtn.layer.borderColor = UIColor.red.cgColor
        navigationController?.isNavigationBarHidden = true
    }
    
    func getDropDownData() {
        
        platformDropDown.didSelect { [weak self] (selectedText , index ,id) in
            self?.selectedPlatformName = selectedText
            self?.mainImage.image = UIImage(named: self?.selectedPlatformName ?? "defaultImage")
            self?.platformDropDown.layer.borderWidth = 0
            self?.resetProgramDropDown()
            Utilities.disabledButton((self?.nextBtn)!)
            guard let selectedDrone = self?.platforms.first (where: { $0.platformName == self?.selectedPlatformName })
                else { return }
            let programs = selectedDrone.availablePrograms
            let programList = programs.map { $0.programName.localized }
            self?.programDropDown.optionArray = programList.removeDuplicates()
        }
        programDropDown.didSelect { (selectedText , index ,id) in
            self.selectedProgramName = selectedText
            self.programDropDown.layer.borderWidth = 0
            Utilities.enabledButton(self.nextBtn)
        }
    }
    
    func resetProgramDropDown() {
        
        programDropDown.text = ""
        selectedProgramName = ""
    }
    
    @IBAction func accountBtnAction(_ sender: UIButton) {
        
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        if selectedPlatformName == "" {
            platformDropDown.layer.borderWidth = 3
        }
        else if selectedProgramName == "" {
            programDropDown.layer.borderWidth = 3
        }
        else {
            performSegue(withIdentifier: Constants.Segues.toDetails, sender: nil)
            setUpElements()
        }
    }
}
