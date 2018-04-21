//
//  Result.swift
//  myBudget
//
//  From victorpimentel / MarvelAPI (Apache-2 License)
//  https://github.com/victorpimentel/MarvelAPI/blob/master/MarvelAPI.playground/Sources/Utils/Result.swift
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

public typealias ResultCallback<Value> = (Result<Value>) -> Void
