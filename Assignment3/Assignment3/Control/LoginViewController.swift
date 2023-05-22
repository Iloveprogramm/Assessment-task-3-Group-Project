//
//  LoginViewController.swift
//  Assignment3
//
//  Created by Huiming He on 22/5/2023.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    // Outlets for text fields
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
    }
    
    // Action when login button is pressed
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        // Check if email field is not empty
        guard let email = loginEmailTextField.text, !email.isEmpty else {
            displayError(message: "Please input your email")
            return
        }
        
        // Check if password field is not empty
        guard let password = loginPasswordTextField.text, !password.isEmpty else {
            displayError(message: "Please input your password")
            return
        }
        
        // Fetch registered email and password from user defaults
        let userDefaults = UserDefaults.standard
        let registeredEmail = userDefaults.string(forKey: "email")
        let registeredPassword = userDefaults.string(forKey: "password")
        
        // Validate entered email and password with registered email and password
        guard email == registeredEmail, password == registeredPassword else {
            displayError(message: "Invalid email or password")
            return
        }
    }
    
    // Function to display error
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
