//
//  URLPathEncoder.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

// Encode an encodable to URL path string
// e.g. parameters:"id:2",path:"myurl/something/{id}/" -> "myurl/something/2/"
public enum URLPathEncoder {
    static func encode<T: Encodable>(_ encodable: T, forUrl templatePath: String) throws -> String {
        let parametersData = try JSONEncoder().encode(encodable)
        let parameters = try JSONDecoder().decode([String: HTTPParameter].self, from: parametersData)
        
        var fullPath: String = templatePath
        for (key, value) in parameters {
            fullPath = fullPath.replacingOccurrences(of: "{\(key)}", with: "\(value)")
        }
        return fullPath
    }
}
