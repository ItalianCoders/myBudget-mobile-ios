//
//  SearchMovementRequest.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct SearchMovementRequest: ApiRequest, PathParameters {
    var resourceName: String {
        return "/protected/v1/accounts/{accountId}/movements"
    }
    
    struct SelfPathParameters: Codable {
        var accountId: String
    }
    
    typealias PathParametersType = SearchMovementRequest.SelfPathParameters
    typealias Response = Page<Movement>
    
    var pathParameters: SearchMovementRequest.SelfPathParameters
    var queryParameters: SearchMovementRequest.SelfQueryParameters
    
    init(accountId: String, year: Int, month: Int, day: Int? = nil, user: String? = nil, category: String? = nil, page: Int) {
        
        pathParameters = .init(accountId: accountId)
        queryParameters = .init(year: year, month: month, day: day, user: user, category: category, page: page)
    }
}

extension SearchMovementRequest: QueryParameters {
    struct SelfQueryParameters: Codable {
        var year: Int
        var month: Int
        var day: Int?
        var user: String?
        var category: String?
        var page: Int
    }
    
    typealias QueryParametersType = SearchMovementRequest.SelfQueryParameters
    
    
}
