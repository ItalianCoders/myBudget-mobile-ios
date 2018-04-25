//
//  LoginViewController.swift
//  myBudget
//
//  Created by Ruggiero Altini on 18/04/18.
//  Copyright © 2018 Ruggiero Altini. All rights reserved.
//

import UIKit

protocol TokenProvider: class {
    var authResponse: JwtAuthenticationResponse? { get }
}

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var authResponse: JwtAuthenticationResponse?
    
    @IBAction func loginWasPressed(_ sender: Any) {
        
        print("Login pressed")
        let client = MyBudgetApiClient()
        
        let loginRequest = LoginRequest(
            body: LoginRequest.JsonBody(
                username: usernameTextField?.text ?? "",
                password: passwordTextField?.text ?? "",
                socialAuthenticationType: .none,
                socialAccessToken: ""))
        
        do {
            try client.send(loginRequest) { [weak self] response in
                print("Result from client::send")
                print(response)
                
                switch response {
                case .success(let jwtAuthResponse):
                    print("success!")
                    print(jwtAuthResponse)
                    self?.authResponse = jwtAuthResponse
                    self?.performSegue(withIdentifier: "login", sender: nil)
                case .failure(let error):
                    // TODO: Insert message to show to the user
                    print("error!")
                    print(error.localizedDescription)
                }
            }
        } catch let error {
            // TODO: Insert message to show to the user
            print(error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            let navVC = segue.destination as! UINavigationController
            let tabVC = navVC.topViewController as! UITabBarController
            let mainVC = tabVC.viewControllers![1] as! MainViewController
            let movVC = tabVC.viewControllers![0] as! MovementsViewController
            
            movVC.tokenProvider = self
            
            //let mainVC = navVC.topViewController as! MainViewController
            mainVC.authResponse = authResponse
        }
    }
}
extension LoginViewController: TokenProvider {}
