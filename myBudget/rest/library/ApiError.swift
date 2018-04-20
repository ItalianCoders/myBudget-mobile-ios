//
//  ApiError.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

public enum ApiError: Error {
    case encoding
    case decoding
    case server(message: String)
    case noHeaders
}
