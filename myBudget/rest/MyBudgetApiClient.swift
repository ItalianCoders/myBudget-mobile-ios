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

public class MyBudgetApiClient {
    private let baseEndpoint = "https://floating-ravine-25522.herokuapp.com/"
    private let session = URLSession(configuration: .default)
    
    public func endpoint<T: ApiRequest>(for request: T) -> URL {
        return URL(string: (baseEndpoint as NSString).appendingPathComponent(request.resourceName))!
    }
    
    public func endpoint<T: ApiRequest & PathParameters>(for request: T) throws -> URL {
        let templatePath = (baseEndpoint as NSString).appendingPathComponent(request.resourceName)
        guard let path = try? URLPathEncoder.encode(request.parameters, forUrl: templatePath) else {
            throw ApiClientError.wrongParameters
        }
        guard let url = URL(string: path) else {
            fatalError("Parsed path non a valid URL")
        }
        return url
    }
    
    public func request<T: TemplateApiRequest>(_ request: T, authToken: String = "", completion: @escaping ResultCallback<T.Response>) {
        
        let endpoint = try! self.endpoint(for: request)
        let request = DefaultNetworking()
            .request(endpoint)
            .httpMethod(.get)
        
        if authToken.count > 0 {
            request.addHeader(field: "x-auth-token", value: authToken)
        }
        request
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
    
    public func post<T: JsonApiRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        
        print("POST request with Body: \(request.body)")
        let endpoint = self.endpoint(for: request)
        print("on endpoint: \(endpoint)")
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(request.body)
        print("Json body encoded: ")
        print(String(data: jsonData, encoding: .utf8) ?? "nil")
        // create post request
        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = "POST"
        
        // insert json data to the request
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                
                completion(.failure(ApiError.server(message: error!.localizedDescription)))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            var objectResponse = try? jsonDecoder.decode(T.Response.self, from: data)
            
            if objectResponse != nil {
                if (request is ResponseHeaders) {
                    if let httpResponse = response as? HTTPURLResponse {
                        var tmp = objectResponse as! ResponseHeaders
                        tmp.responseHeaders = httpResponse.allHeaderFields as! [String: String]
                        objectResponse = tmp as? T.Response
                    }
                }
                completion(.success(objectResponse!))
            } else {
                completion(.failure(ApiError.decoding))
            }
            //print("JWT RESPONSE: ")
            //print(jwtAuthResponse!)
            /*let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }*/
        }
        
        task.resume()
        
    }
    
    public func send<T: ApiRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        
        let endpoint = self.endpoint(for: request)
        
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            
            if let data = data {
                do {
                    print("RESPONSE = \(data)")
                    let response = try JSONDecoder().decode(T.Response.self, from: data)
                    
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
