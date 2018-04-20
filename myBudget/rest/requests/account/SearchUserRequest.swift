//
//  SearchUser.swift
//  myBudget
//
//  Created by Ruggiero Altini on 20/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct SearchUserRequest: ApiRequest, PathParameters, QueryParameters {
    typealias PathParametersType = SelfPathParameters
    
    typealias Response = AccountDetails
    
    var resourceName: String {
        return "/protected/v1/accounts/{id}/invite/users"
    }
    
    struct SelfPathParameters: Codable {
        public var id: String
    }
    
    struct SelfQueryParameters: Codable {
        public var search: String
    }
    
    var pathParameters: SearchUserRequest.SelfPathParameters
    var queryParameters: SearchUserRequest.SelfQueryParameters
    
    init(id: String, searchValue search: String) {
        pathParameters = SearchUserRequest.SelfPathParameters(id: id)
        queryParameters = SearchUserRequest.SelfQueryParameters(search: search)
    }
}
