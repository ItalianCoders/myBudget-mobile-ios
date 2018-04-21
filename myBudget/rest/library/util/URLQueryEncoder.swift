//
//  URLQueryEncoder.swift
//  myBudget
//
//  struct URLQueryEncoder and URLQueryEncoder::encode<T:Encodable>(:T) -> String
//  From victorpimentel / MarvelAPI (Apache-2 License)
//  https://github.com/victorpimentel/MarvelAPI/blob/master/MarvelAPI.playground/Sources/Utils/URLQueryEncoder.swift
//
//  Other additions by Ruggiero Altini
//

import Foundation

/// Encodes any encodable to a URL query string
public enum URLQueryEncoder {
    static func encode<T: Encodable>(_ encodable: T) throws -> String {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        return parameters
            .map({ "\($0)=\($1)" })
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    static func encode<T: Encodable>(_ encodable: T) throws -> [URLQueryItem] {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        
        return parameters.map { (arg) -> URLQueryItem in
            
            let (key, value) = arg
            return URLQueryItem(name: key, value: value.description)
        }
        /*
        return parameters
            .map({ "\($0)=\($1)" })
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!*/
    }
}
