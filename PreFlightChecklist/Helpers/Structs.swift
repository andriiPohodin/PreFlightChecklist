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
        
        static let firstVC = "FirstViewController"
    }
    
    struct Segues {
        
        static let signUpToMain = "signUpToMainVC"
        static let logInToMain = "logInToMainVC"
        static let toDetails = "toDetails"
        static let toLesson = "toLesson"
    }
}
