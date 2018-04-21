//
//  MyBudgetApiClient.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public enum ApiClientError: Error {
    case wrongParameters
}

fileprivate extension UrlRequestFactory {
    @discardableResult
    func addAuthTokenIfNonEmpty(_ authToken: String) -> UrlRequestFactory {
        if authToken.count > 0 {
            self.addHeader(field: "x-auth-token", value: authToken)
        }
        return self
    }
}

public class MyBudgetApiClient {
    private let baseEndpoint = "https://floating-ravine-25522.herokuapp.com/"
    private let session = URLSession(configuration: .default)
    
    public func send<T: JsonApiRequest>(_ request: T, authToken: String = "", completion: @escaping ResultCallback<T.Response>) throws {
        
        let endpoint = self.endpoint(for: request)
        try DefaultNetworking()
            .requestFactory(endpoint)
            .addAuthTokenIfNonEmpty(authToken)
            .httpMethod(request.type)
            .jsonBody(request.body)
            .sharedDataTask { data, response, error in
            
                guard let data = data, error == nil else {
                    completion(.failure(ApiError.server(message: error!.localizedDescription)))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let objectResponse = try jsonDecoder.decode(T.Response.self, from: data)
                    completion(.success(objectResponse))
                } catch let errorDecoding {
                    completion(.failure(errorDecoding))
                }
        }.resume()
    }
    
    public func send<T: TemplateApiRequest>(_ request: T, authToken: String = "", completion: @escaping ResultCallback<T.Response>) {
        
        let endpoint = try! self.endpoint(for: request)
        let _ = DefaultNetworking()
            .requestFactory(endpoint)
            .httpMethod(.get)
            .addAuthTokenIfNonEmpty(authToken)
            .sharedDataTask { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(ApiError.server(message: error!.localizedDescription)))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let objectResponse = try jsonDecoder.decode(T.Response.self, from: data)
                    completion(.success(objectResponse))
                } catch let errorDecoding {
                    completion(.failure(errorDecoding))
                }
        }.resume()
    }
    
    // TODO: Move this logic in a separate class and add consistency
    public func endpoint<T: ApiRequest>(for request: T) -> URL {
        return URL(string: (baseEndpoint as NSString).appendingPathComponent(request.resourceName))!
    }
    
    public func endpoint<T: ApiRequest & PathParameters>(for request: T) throws -> URL {
        let templatePath = (baseEndpoint as NSString).appendingPathComponent(request.resourceName)
        guard let path = try? URLPathEncoder.encode(request.pathParameters, forUrl: templatePath) else {
            throw ApiClientError.wrongParameters
        }
        guard let url = URL(string: path) else {
            fatalError("Parsed path non a valid URL")
        }
        return url
    }
    
    public func endpoint<T: ApiRequest & QueryParameters>(for request: T) throws -> URL? {
        let basePath = (baseEndpoint as NSString).appendingPathComponent(request.resourceName)
        var urlComponents = URLComponents(string: basePath)
        urlComponents?.queryItems = try URLQueryEncoder.encode(request.queryParameters)
        return urlComponents?.url
    }
    
    public func endpoint<T: ApiRequest & PathParameters & QueryParameters>(for request: T) throws -> URL? {
        
        let templatePath = (baseEndpoint as NSString).appendingPathComponent(request.resourceName)
        let specificPath = try URLPathEncoder.encode(request.pathParameters, forUrl: templatePath)
        
        let parameters: String = try URLQueryEncoder.encode(request.queryParameters)
        
        return URL(string: specificPath + parameters)
    }
}
