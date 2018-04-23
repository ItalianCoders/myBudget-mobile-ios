//
//  Endpoint.swift
//  myBudget
//
//  Created by Ruggiero Altini on 23/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

struct Endpoint {
    let baseEndpoint: String
    
    public func `for`<T: ApiRequest>(request: T) -> URL {
        return URL(string: (baseEndpoint as NSString).appendingPathComponent(request.resourceName))!
    }

    public func `for`<T: ApiRequest & PathParameters>(request: T) throws -> URL {
        let templatePath = (baseEndpoint as NSString).appendingPathComponent(request.resourceName)
        guard let path = try? URLPathEncoder.encode(request.pathParameters, forUrl: templatePath) else {
            throw ApiClientError.wrongParameters
        }
        guard let url = URL(string: path) else {
            fatalError("Parsed path non a valid URL")
        }
        return url
    }

    public func `for`<T: ApiRequest & QueryParameters>(request: T) throws -> URL? {
        let basePath = (baseEndpoint as NSString).appendingPathComponent(request.resourceName)
        var urlComponents = URLComponents(string: basePath)
        urlComponents?.queryItems = try URLQueryEncoder.encode(request.queryParameters)
        return urlComponents?.url
    }

    public func `for`<T: ApiRequest & PathParameters & QueryParameters>(request: T) throws -> URL? {
        
        let templatePath = (baseEndpoint as NSString).appendingPathComponent(request.resourceName)
        let specificPath = try URLPathEncoder.encode(request.pathParameters, forUrl: templatePath)
        
        let parameters: String = try URLQueryEncoder.encode(request.queryParameters)
        
        return URL(string: specificPath + parameters)
    }
}
