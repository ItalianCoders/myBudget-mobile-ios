//
//  LoginResult.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public enum LoginResult {
    case valid(
        refreshToken: String,
        accessToken: String,
        user: User,
        accounts: [Account],
        socialAuthenticationType: SocialType
    )
    case invalid
    case error
}
