//
//  RegisterViewController.swift
//  Assignment3
//
//  Created by Huiming He on 22/5/2023.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {

    // Outlets for text fields
    @IBOutlet weak var registerEmailTextField: UITextField!
    @IBOutlet weak var registerPasswordTextField: UITextField!
    @IBOutlet weak var registerConfirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
    }
    
    // Action when register button is pressed
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        checkInputAndSave()
    }
    
    // Check input and save to user defaults
    func checkInputAndSave() {
        // Check if email is valid
        guard let email = registerEmailTextField.text, isValidEmail(email) else {
            displayError(message: "Invalid format Email")
            return
        }
        
        // Check if password is valid
        guard let password = registerPasswordTextField.text, isValidPassword(password) else {
            displayError(message: "Password must be at least 8 characters, and include uppercase letters, lowercase letters, and numbers.")
            return
        }
        
        // Check if passwords match
        guard let confirmPassword = registerConfirmPasswordTextField.text, password == confirmPassword else {
            displayError(message: "Passwords do not match")
            return
        }
        
        // Save email and password to user defaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(email, forKey: "email")
        userDefaults.set(password, forKey: "password")
        
        // All conditions met, perform segue to login view
        self.performSegue(withIdentifier: "goLogin", sender: self)
    }
    
    // Function to check if email is valid
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Function to check if password is valid
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }

    // Function to display error
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Function to decide whether to perform segue
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goLogin" {
            return isValidEmail(registerEmailTextField.text ?? "") &&
                   isValidPassword(registerPasswordTextField.text ?? "") &&
                   (registerPasswordTextField.text == registerConfirmPasswordTextField.text)
        }
        return true
    }
}
