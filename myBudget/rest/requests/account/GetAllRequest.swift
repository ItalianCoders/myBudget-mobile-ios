//
//  GetAll.swift
//  myBudget
//
//  Created by Ruggiero Altini on 20/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public struct GetAllRequest: ApiRequest {
    public typealias Response = [Account]
    
    public var resourceName: String {
        return "/protected/v1/accounts"
    }
}
