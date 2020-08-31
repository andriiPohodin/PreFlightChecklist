import Foundation

struct Platform {
    var platformName: String
    var availablePrograms: [Program]
}

struct Program {
    var programName: String
    var isIndoor: Bool
    var stepData: [ProgramStep]
}

struct ProgramStep {
    var stepNumber: Int
    var stepDescription: String
}

struct Constants {
    
    struct Storyboard {
        
        static let mainVC = "MainViewController"
        static let firstVC = "FirstViewController"
        static let tabBarVC = "tabBarVC"
        static let navVC = "navVC"
    }
    
    struct Segues {
        
        static let signUpToMain = "signUpToMainVC"
        static let logInToMain = "logInToMainVC"
        static let toDetails = "toDetails"
        static let toLesson = "toLesson"
    }
}
