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
    
    static let storageRef = "gs://preflightchecklist-323e2.appspot.com/profile"
    
    struct Storyboard {
        
        static let main = "Main"
        static let logIn = "LogIn"
    }
    
    struct Segues {
        
        static let toDetails = "toDetails"
        static let toLesson = "toLesson"
    }
}
