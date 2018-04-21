//
//  JwtAuthenticationResponse.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public struct JwtAuthenticationResponse: Codable {
    
    let user: User?
    
    let refreshToken: String
    
    let accessToken: String
    
    let accounts: [Account]
}
