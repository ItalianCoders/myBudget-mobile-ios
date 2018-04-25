//
//  SimpleDate.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct SimpleDate: Hashable, Equatable {
    var year: Int
    var month: Int
    var day: Int
    
    init(by date: Date) {
        let calendar = Calendar.current
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
    }
}

extension SimpleDate {
    init(bySeconds seconds: Int64) {
        let date = Date(timeIntervalSince1970: Double(seconds))
        self.init(by: date)
    }
    
    init(byMilliseconds ms: Int64) {
        let date = Date(timeIntervalSince1970: Double(ms / 1000))
        self.init(by: date)
    }
}
