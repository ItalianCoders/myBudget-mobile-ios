//
//  RegisterRequest.swift
//  myBudget
//
//  Created by Ruggiero Altini on 20/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

// Class for register request to the backend API
// Takes as parameter a UserBody object, and gives as result a User object
struct RegisterRequest: JsonApiRequest {
    let type: JsonRequestType = .post
    
    typealias Body = RegisterRequest.UserBody
    
    typealias Response = User
    
    public var resourceName: String {
        return "/public/v1/register"
    }
    
    var body: UserBody
    
    // Parameters
    // Similar as RegistrationUser class in Android project
    struct UserBody: Codable {
        var username: String
        var password: String?
        
        var email: String = ""
        var firstname: String = ""
        var lastname: String = ""
        var gender: Gender?
        
    }

    
    init(body: UserBody) {
        self.body = body
    }
}
