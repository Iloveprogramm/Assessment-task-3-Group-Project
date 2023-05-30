//
//  CheckoutViewController.swift
//  Assignment3
//
//  Created by Zhaoyu Pan on 26/5/2023.
//

import Foundation
import UIKit

class CheckoutViewController: UIViewController {

    struct OrderDetails {
            var firstName: String
            var lastName: String
            var address: String
            var city: String
            var state: String
            var paymentType: String
        }

    var car: Car?
    @IBOutlet weak var bookingDetailsLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var paymentTypeTextField: UITextField!
    @IBOutlet weak var checkOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let car = car {
            let bookingDetails = "You are choosing \(car.title), \(car.price)$ Per Day."
            bookingDetailsLabel.text = bookingDetails
        }
    }
    // Check Out Button Action
    @IBAction func checkOutButtonTapped(_ sender: UIButton) {
        // validate the input fields
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            displayError(message: "Please enter your first name")
            return
        }
        
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
            displayError(message: "Please enter your last name")
            return
        }
        
        guard let address = addressTextField.text, !address.isEmpty else {
            displayError(message: "Please enter your address")
            return
        }
        
        guard let city = cityTextField.text, !city.isEmpty else {
            displayError(message: "Please enter your city")
            return
        }
        
        guard let state = stateTextField.text, !state.isEmpty else {
            displayError(message: "Please enter your state")
            return
        }
        
        guard let paymentType = paymentTypeTextField.text, !paymentType.isEmpty else {
            displayError(message: "Please enter your payment type")
            return
        }
    }

    
    // this function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check the segue identifier
        if segue.identifier == "goToConfirmation" {
            // set the destination view controller
            let destinationVC = segue.destination as! ConfirmationViewController
            // pass the data
            destinationVC.firstName = firstNameTextField.text
            destinationVC.lastName = lastNameTextField.text
            destinationVC.address = addressTextField.text
            destinationVC.city = cityTextField.text
            destinationVC.state = stateTextField.text
            destinationVC.paymentType = paymentTypeTextField.text
        }
    }
    
    func displayError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

}
