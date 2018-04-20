//
//  EditAccountRequest.swift
//  myBudget
//
//  Created by Ruggiero Altini on 20/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct EditAccountRequest: JsonApiRequest, PathParameters {
    let resourceName: String = "/protected/v1/accounts/{id}"
    let type: JsonRequestType = .put
    
    typealias Body = Account
    typealias PathParametersType = SelfPathParameters
    typealias Response = Nothing
    
    var body: Account
    
    struct SelfPathParameters: Codable {
        var id: String
    }
    
    var pathParameters: EditAccountRequest.SelfPathParameters
    
    init(accountId id: String, account body: Account) {
        pathParameters = .init(id: id)
        self.body = body
    }
}
