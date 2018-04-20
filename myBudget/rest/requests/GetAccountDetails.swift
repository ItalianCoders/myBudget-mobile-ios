//
//  GetAccountDetails.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public struct GetAccountDetails: ApiRequest, PathParameters {
    public typealias _Parameters = Parameters
    
    public typealias Response = AccountDetails
    
    public var resourceName: String {
        return "/protected/v1/accounts/{id}"
    }
    
    public struct Parameters: Codable {
        public var id: String
    }
    
    public var parameters: GetAccountDetails.Parameters
    
    init(id: String) {
        parameters = GetAccountDetails.Parameters(id: id)
    }
}
