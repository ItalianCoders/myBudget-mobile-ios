//
//  Currency.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

extension Double {
    func formattedCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let formattedAmount = formatter.string(from: self as NSNumber) {
            return formattedAmount
        }
        return nil
    }
}
