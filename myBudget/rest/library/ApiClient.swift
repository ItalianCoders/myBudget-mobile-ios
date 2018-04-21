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

public enum JsonRequestType: String, Codable {
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct Nothing: Decodable {}

public protocol ApiRequest: Encodable {
    associatedtype Response: Decodable
    
    // The resourceName is the endpoint in the API
    var resourceName: String { get }
}

public protocol JsonApiRequest: ApiRequest {
    associatedtype Body: Codable
    
    var type: JsonRequestType { get }
    
    var body: Body { get set }
}

public protocol PathParameters: Codable {
    associatedtype PathParametersType: Encodable
    
    var pathParameters: PathParametersType { get }
}

public protocol QueryParameters: Encodable {
    associatedtype QueryParametersType: Encodable
    
    var queryParameters: QueryParametersType { get }
}

public typealias TemplateApiRequest = ApiRequest & PathParameters
public typealias QueriedApiRequest = ApiRequest & QueryParameters

public protocol ResponseHeaders: Codable {
    var responseHeaders: [String: String] { get set }
}
