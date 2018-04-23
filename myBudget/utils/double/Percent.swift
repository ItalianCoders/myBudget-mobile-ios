//
//  Percent.swift
//  myBudget
//
//  Created by Ruggiero Altini on 23/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", self)
    }
}
