//
//  JwtAuthenticationResponse.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public struct JwtAuthenticationResponse: Codable, ResponseHeaders {
    
    let user: User//? = nil
    
    let refreshToken: String//? = nil
    
    let accounts: [Account]//? = nil
    
    private enum CodingKeys: String, CodingKey {
        case user
        case refreshToken
        case accounts
    }
    
    public var responseHeaders: [String: String] = [:]
}
