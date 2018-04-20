//
//  Movement.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation


public enum MovementType: Int, Codable {
    case incoming = 0
    case expense = 1
    case both = 2
}

public struct MovementCategory: Codable {
    let type: MovementType?
    let id: String
    let value: String?
    let iconId: Int?
    
    let editable: Bool?
    
    
    private enum CodingKeys: String, CodingKey {
        case type
        case id
        case value
        case iconId
        case editable = "isEditable"
    }
}

public struct Movement: Codable {
    
    let id: String
    var type: MovementType?
    var amount: Double?
    var executedBy: User?
    var executedAt: Int64?
    var updatedAt: Int64?
    var note: String?
    var category: MovementCategory?
    
    var account: Account? = nil
    let auto = false
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case amount
        case executedBy
        case executedAt
        case updatedAt
        case note
        case category
    }
}
