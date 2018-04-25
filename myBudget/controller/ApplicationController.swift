//
//  ApplicationController.swift
//  myBudget
//
//  Created by Ruggiero Altini on 25/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import Foundation

protocol AppRequest: Encodable {
    associatedtype Response: Decodable
    
}

class ApplicationController {
    // MARK: - Stateful
    private var restAuthToken: String = ""
    private var restApiClient: MyBudgetApiClient
    
    init(restApiClient: MyBudgetApiClient, restAuthToken: String) {
        self.restAuthToken = restAuthToken
        self.restApiClient = restApiClient
    }
    
    /// Handles a POST/PUT/DELETE Rest API Request
    func handle<T: JsonApiRequest>(request: T, responseHandler: @escaping ResultCallback<T.Response>) throws {
        
        try restApiClient.send(request, authToken: restAuthToken, completion: responseHandler)
    }
    
    /// Handles a GET Rest API Request where there are URL has parameter arguments
    func handle<T: TemplateApiRequest>(request: T, responseHandler: @escaping ResultCallback<T.Response>) {
        
        restApiClient.send(request, authToken: restAuthToken, completion: responseHandler)
    }
    
    /// Handles a GET Rest API Request where there are URL has parameter arguments and
    /// it has query arguments
    func handle<T: TemplateQueriedApiRequest>(request: T, responseHandler: @escaping ResultCallback<T.Response>) {
        
        restApiClient.send(request, authToken: restAuthToken, completion: responseHandler)
    }
    
    func handle<T: AppRequest>(request: T, responseHandler: (ResultCallback<T.Response>) -> ()) {
        
    }
    
    // MARK: - Stateless
    
    private static let restApiClient = MyBudgetApiClient()
    
    static func handle<T: JsonApiRequest>(request: T, authToken: String, responseHandler: @escaping ResultCallback<T.Response>) throws {
        
        try ApplicationController.restApiClient.send(request, authToken: authToken, completion: responseHandler)
    }
    static func handle<T: TemplateApiRequest>(request: T, authToken: String, responseHandler: @escaping ResultCallback<T.Response>) {
        
        ApplicationController.restApiClient.send(request, authToken: authToken, completion: responseHandler)
    }
    static func handle<T: TemplateQueriedApiRequest>(request: T, authToken: String, responseHandler: @escaping ResultCallback<T.Response>) {
        
        ApplicationController.restApiClient.send(request, authToken: authToken, completion: responseHandler)
    }
}
