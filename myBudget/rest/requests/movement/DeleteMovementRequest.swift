//
//  DeleteMovementRequest.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct DeleteMovementRequest: JsonApiRequest, PathParameters {
    var resourceName: String {
        return "/protected/v1/accounts/{accountId}/movements/{movementId}"
    }
    
    public struct SelfPathParameters: Codable {
        public var accountId: String
        public var movementId: String
    }
    
    typealias Body = Movement
    typealias PathParametersType = DeleteMovementRequest.SelfPathParameters
    typealias Response = Nothing
    
    var type: JsonRequestType = .delete
    var body: Movement
    var pathParameters: DeleteMovementRequest.SelfPathParameters
    
    init(body: Movement, accountId: String, movementId: String) {
        self.body = body
        pathParameters = .init(accountId: accountId, movementId: movementId)
    }
}
