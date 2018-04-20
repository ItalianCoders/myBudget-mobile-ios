//
//  RoundedTextField.swift
//  myBudget
//
//  Created by Ruggiero Altini on 18/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit

// This class gives a template for a text field with facility to set corner radius
// both in code and in Interface Builder.
// It also provides an inset property to set a margin for the text from left.
@IBDesignable
class RoundedTextField: UITextField {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var paddingLeft: CGFloat = 0 {
        didSet {
            self.layer.sublayerTransform = CATransform3DMakeTranslation(paddingLeft, 0, 0)
        }
    }
}

