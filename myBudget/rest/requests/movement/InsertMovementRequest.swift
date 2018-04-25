//
//  InsertMovementRequest.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct InsertMovementRequest: JsonApiRequest, PathParameters {
    var type: JsonRequestType = .post
    
    typealias Body = Movement
    
    typealias PathParametersType = InsertMovementRequest.SelfPathParameters
    
    typealias Response = Nothing
    
    public struct SelfPathParameters: Codable {
        public var accountId: String
    }
    
    var body: Movement
    public var pathParameters: InsertMovementRequest.SelfPathParameters
    
    var resourceName: String {
        return "/protected/v1/accounts/{accountId}/movements"
    }
    
    init(body: Movement, accountId: String) {
        self.body = body
        pathParameters = .init(accountId: accountId)
    }
}
