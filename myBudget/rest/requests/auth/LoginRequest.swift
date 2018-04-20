//
//  LoginRequest.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public struct LoginRequest: JsonApiRequest, ResponseHeaders {
    public let type: JsonRequestType = .post
    
    public typealias Body = LoginRequest.JsonBody
    
    public typealias Response = JwtAuthenticationResponse
    
    public var resourceName: String {
        return "/public/v1/login"
    }
    
    public var body: JsonBody
    
    public var responseHeaders: [String : String] = [:]
    
    // Parameters
    public struct JsonBody: Codable {
        public let username: String?
        public let password: String?
        public let socialAuthenticationType: SocialType?
        public let socialAccessToken: String?
        
        init(username: String,
             password: String,
             socialAuthenticationType: SocialType,
             socialAccessToken: String) {
            
            self.username = username
            self.password = password
            self.socialAuthenticationType = socialAuthenticationType
            self.socialAccessToken = socialAccessToken
        }
    }
    
    init(body: JsonBody) {
        self.body = body
    }
}
