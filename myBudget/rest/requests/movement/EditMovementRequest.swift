//
//  EditMovementRequest.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct EditMovementRequest: JsonApiRequest, PathParameters {
    var resourceName: String {
        return "/protected/v1/accounts/{accountId}/movements/{movementId}"
    }
    
    var type: JsonRequestType = .put
    
    typealias Body = Movement
    
    typealias PathParametersType = EditMovementRequest.SelfPathParameters
    
    typealias Response = Nothing
    
    public struct SelfPathParameters: Codable {
        public var accountId: String
        public var movementId: String
    }
    
    var body: Movement
    public var pathParameters: EditMovementRequest.SelfPathParameters
    
    init(body: Movement, accountId: String, movementId: String) {
        self.body = body
        pathParameters = .init(accountId: accountId, movementId: movementId)
    }
}
