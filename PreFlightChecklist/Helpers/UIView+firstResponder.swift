//
//  UIView+firstResponder.swift
//  PreFlightChecklist
//
//  Created by Andrii Pohodin on 28.07.2020.
//  Copyright © 2020 Andrii Pohodin. All rights reserved.
//

import UIKit

extension UIView {
    func currentFirstResponder() -> UIResponder? {
        if self.isFirstResponder {
            return self
        }
        
        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }
        
        return nil
     }
}


