//
//  ApiClient.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public protocol ApiClient {
    //func send(_ request: ApiRequest, completion: ResultCallback)
    func send<T: ApiRequest>(
        _ request: T,
        completion: @escaping ResultCallback<T.Response>
    )
}

public enum RequestType: String, Codable {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol ApiRequest: Encodable {
    associatedtype Response: Decodable
    
    // The resourceName is the endpoint in the API
    var resourceName: String { get }
}

public protocol JsonApiRequest: ApiRequest {
    associatedtype Body: Codable
    
    var body: Body { get set }
}

public protocol PathParameters: Codable {
    associatedtype _Parameters: Encodable
    
    var parameters: _Parameters { get }
}

public typealias TemplateApiRequest = ApiRequest & PathParameters

public protocol ResponseHeaders: Codable {
    var responseHeaders: [String: String] { get set }
}
