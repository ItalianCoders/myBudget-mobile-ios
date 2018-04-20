//
//  Account.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public enum AccountStatus: Int, Codable {
    case ok = 0
    case warning = 1
    case critical = 2
}

public struct Account: Codable {
    var id: String
    var name: String
    var description: String?
    var status: AccountStatus? = nil
    var numberOfUsers: Int?
    var defaultUsername: String? = nil
}
