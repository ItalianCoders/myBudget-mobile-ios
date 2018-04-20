//
//  GetAccountDetails.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public struct GetAccountDetailsRequest: ApiRequest, PathParameters {
    public typealias PathParametersType = Parameters
    
    public typealias Response = AccountDetails
    
    public var resourceName: String {
        return "/protected/v1/accounts/{id}"
    }
    
    public struct Parameters: Codable {
        public var id: String
    }
    
    public var pathParameters: GetAccountDetailsRequest.Parameters
    
    init(id: String) {
        pathParameters = GetAccountDetailsRequest.Parameters(id: id)
    }
}
