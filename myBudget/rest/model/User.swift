//
//  User.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public enum Gender: Int, Codable {
    case male = 0
    case female = 1
    case other = 2
}

public enum SocialType: Int, Codable {
    case none = 0
    case facebook = 1
    case google = 2
}

public struct User: Codable {
    var username: String
    var password: String?
    var email: String?
    var firstname: String?
    var lastname: String?
    var alias: String?
    var gender: Gender?
    var socialType: SocialType?
    var profileImageUrl: String?
}
