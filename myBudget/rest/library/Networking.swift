//
//  Networking.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

enum ContentType: String {
    case json = "application/json; charset=utf-8"
}

class UrlRequestFactory {
    var urlRequest: URLRequest
    
    init(url: URL) {
        urlRequest = URLRequest(url: url)
    }
    
    @discardableResult
    func httpMethod(_ type: RequestType) -> UrlRequestFactory {
        urlRequest.httpMethod = type.rawValue
        return self
    }
    
    @discardableResult
    func httpMethod(_ type: JsonRequestType) -> UrlRequestFactory {
        urlRequest.httpMethod = type.rawValue
        return self
    }
    
    @discardableResult
    func contentType(_ type: ContentType) -> UrlRequestFactory {
        urlRequest.setValue(type.rawValue, forHTTPHeaderField: "Content-Type")
        return self
    }
    
    @discardableResult
    func jsonBody<T: Encodable>(_ body: T) throws -> UrlRequestFactory {
        let jsonData = try JSONEncoder().encode(body)
        urlRequest.httpBody = jsonData
        return self
    }
    
    @discardableResult
    func addHeader(field: String, value: String) -> UrlRequestFactory {
        urlRequest.setValue(value, forHTTPHeaderField: field)
        return self
    }
    
    @discardableResult
    func sharedDataTask(completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: urlRequest, completionHandler: completion)
    }
}

protocol Networking {
    func requestFactory(_ urlString: String) -> UrlRequestFactory
    func requestFactory(_ url: URL) -> UrlRequestFactory
}

extension Networking {
    func requestFactory(_ url: URL) -> UrlRequestFactory {
        return UrlRequestFactory(url: url)
    }
    
    func requestFactory(_ urlString: String) -> UrlRequestFactory {
        return UrlRequestFactory(url: URL(string: urlString)!)
    }
}

struct DefaultNetworking: Networking {}
