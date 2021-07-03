//
//  AuthViewController.swift
//  AEONTestApp
//
//  Created by Nikita Makarov on 02.07.2021.
//

import UIKit
import Alamofire

class AuthViewController: UIViewController {
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    let segueIdentifire = "showPayments"

    let loginLink = "http://82.202.204.94/api-test/login"
    let headers: HTTPHeaders = ["app-key" : "12345", "v" : "1"]
    
    var token: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Persistance.shared.userToken != nil {
            print(Persistance.shared.userToken!)
            performSegue(withIdentifier: self.segueIdentifire, sender: nil)
        }
      
    }
    

    @IBAction func logInButton(_ sender: UIButton) {
        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        print(login)
        print(password)
        logIn(login: login, password: password)
        
    }
    

    
    
    private func logIn(login: String, password: String) {
        
        let parameters = [ "login" : login, "password" : password]
         AF.request(loginLink,
                   method: .post,
                   parameters: parameters,
                   headers: headers)
                         .response { response in
                    
                                if let objects = try? response.result.get() {

                                do {
                                   let fetchToken = try JSONDecoder().decode(GetToken.self, from: objects)
                                    if (fetchToken.error?.code) != nil {
                                        
                                        let alert = UIAlertController(title: "Sorry!", message: "This data not found, please try again", preferredStyle: .alert)
                                        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                                        alert.addAction(action)
                                        self.present(alert, animated: true, completion: nil)
                                    }
                                    
                                    else {
                                            
                                        Persistance.shared.userToken = fetchToken.response?.token
                                        self.performSegue(withIdentifier: self.segueIdentifire, sender: nil)
                                        self.loginTextField.text = ""
                                        self.passwordTextField.text = ""
                                    }
                                } catch let error {
                                    print(error)
                                    
                                }
                                }
        }
    }
}
