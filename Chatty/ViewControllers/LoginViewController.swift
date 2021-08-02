//
//  LoginViewController.swift
//  Chatty
//
//  Created by Marina on 20/07/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        let email = (emailTextField.text?.trimmingWhiteSpaces())!
        let password = passwordTextField.text!
        UserManager.reference.loginUser(with: email, and: password) { sucess, error in
            DispatchQueue.main.async {
                if sucess{
                    self.performSegue(withIdentifier: K.Segues.SIGNIN_TO_CONTACTS, sender: nil)
                }
                // show error message
                print(error!.localizedDescription)
                self.showAlert(with: .loginFailed)
            }
            
        }
    }
    
    
}
