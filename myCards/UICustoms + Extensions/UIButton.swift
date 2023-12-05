//
//  UIButton.swift
//  myCards
//
//  Created by Mohamed Ali on 05/12/2023.
//

import UIKit

extension UIButton {
    
    func SetButtonEnabledOrDisabled(status: Bool) {
        if status {
            self.isEnabled = true
            self.layer.opacity = 1
        }
        else {
            self.isEnabled = false
            self.layer.opacity = 0.5
        }
    }
}
