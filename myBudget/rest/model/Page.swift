//
//  Page.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct Page<T: Codable>: Codable {
    var content: [T]?
    
    var isFirst: Bool? = false
    var isLast: Bool? = false
    var number: Int? = 0
    var totalPages: Int? = 0
    var size: Int? = 0
    var totalElements: Int64? = 0
}
