import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

//extension UIView {
//    var firstResponder: UIView? {
//        guard !isFirstResponder else { return self }
//
//        for subview in subviews {
//            if let firstResponder = subview.firstResponder {
//                return firstResponder
//            }
//        }
//
//        return nil
//    }
//}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
