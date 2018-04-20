//
//  InsertAccountRequest.swift
//  myBudget
//
//  Created by Ruggiero Altini on 20/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct InsertAccountRequest: JsonApiRequest {
    // ApiRequest Associated Properties
    let resourceName: String = "/protected/v1/accounts"
    
    // JsonApiRequest Associated Properties
    let type: JsonRequestType = .post
    
    // JsonApiRequest Associated Types
    typealias Body = InsertAccountRequest.AccountCreationBody
    typealias Response = Nothing
    
    struct AccountCreationBody: Codable {
        var name: String
        var description: String?
        var initialBalance: Double?
    }
    
    var body: AccountCreationBody
    
    init(name: String, description: String = "", initialBalance: Double = 0.0) {
        self.body = .init(name: name, description: description, initialBalance: initialBalance)
    }
}
