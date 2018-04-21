//
//  MainViewController.swift
//  myBudget
//
//  Created by Ruggiero Altini on 19/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var incomingCard: HeaderBox!
    @IBOutlet weak var expenseCard: HeaderBox!
    @IBOutlet weak var balanceCard: HeaderBox!
    
    var authResponse: JwtAuthenticationResponse!
    var accessToken: String {
        return authResponse.accessToken
        //print(authResponse.responseHeaders)
        //return authResponse.responseHeaders["X-Auth-Token"]!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accessToken: String = self.accessToken
        
        MyBudgetApiClient().send(GetAccountDetailsRequest(id: authResponse.accounts[0].id), authToken: accessToken) {
            result in
            
            switch result {
            case .success(let accountDetails):
                print("ACCOUNT DETAILS: ")
                print(accountDetails)
                
                DispatchQueue.main.async {
                    self.navigationItem.title = accountDetails.name
                    self.incomingCard.text = accountDetails.totalMonthlyIncoming.formattedCurrency()
                    self.expenseCard.text = accountDetails.totalMonthlyExpense.formattedCurrency()!
                    self.balanceCard.text = (accountDetails.totalMonthlyIncoming-accountDetails.totalMonthlyExpense).formattedCurrency()
                }
            case .failure(let error):
                print("ERROR:")
                print(error)
            }
        }
    }
    /*
    @IBAction func button(_ sender: Any) {
        
        let accessToken: String = self.accessToken
        
        MyBudgetApiClient().send(GetAccountDetailsRequest(id: authResponse.accounts[0].id), authToken: accessToken) {
            accountDetails in
            
            print("ACCOUNT DETAILS: ")
            print(accountDetails)
        }
    }*/
    
}
