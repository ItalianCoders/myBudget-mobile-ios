//
//  AccountDetails.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public struct AccountDetails: Codable {
    // Account
    var id: String
    
    var name: String
    
    var description: String?
    
    var status: AccountStatus?
    
    var numberOfUsers: Int?
    
    var defaultUsername: String?
    
    // AccountDetails
    let incomingCategoriesAvailable: [MovementCategory]?
    let expenseCategoriesAvailable: [MovementCategory]?
    
    let totalMonthlyIncoming: Double
    let totalMonthlyExpense: Double
    
    let incomingOverviewMovement: [String: Double]?
    let expenseOverviewMovement: [String: Double]?
    
    let lastMovements: [Movement]?
    
    let members: [User]?
    
    let administrators: [String]?
    
    let numberOfPendingAccountInvites: Int?
}
