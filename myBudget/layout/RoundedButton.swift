//
//  RoundedButton.swift
//  myBudget
//
//  Created by Ruggiero Altini on 18/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit

// This class gives a template for a button with facility to set corner radius
// both in code and in Interface Builder.
@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
}

