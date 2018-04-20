//
//  InviteUser.swift
//  myBudget
//
//  Created by Ruggiero Altini on 20/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct InviteUserRequest: ApiRequest, PathParameters {
    typealias PathParametersType = Parameters
    
    typealias Response = AccountDetails
    
    var resourceName: String {
        return "/protected/v1/accounts/{id}/invite/users/{username}"
    }
    
    struct Parameters: Codable {
        var id: String
        var username: String
    }
    
    var pathParameters: InviteUserRequest.Parameters
    
    init(accountId id: String, username: String) {
        pathParameters = InviteUserRequest.Parameters(id: id, username: username)
    }
}
