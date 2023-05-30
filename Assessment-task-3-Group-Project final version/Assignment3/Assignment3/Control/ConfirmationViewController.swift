//
//  ConfirmationViewController.swift
//  Assignment3
//
//  Created by Zhaoyu Pan on 26/5/2023.
//

import Foundation
import UIKit

class ConfirmationViewController: UIViewController {

    // Variables to hold order data
    var firstName: String?
    var lastName: String?
    var address: String?
    var city: String?
    var state: String?
    var paymentType: String?

    // Outlets for display labels
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var paymentTypeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set label text with passed data
        firstNameLabel.text = "First Name: \(firstName ?? "")"
        lastNameLabel.text = "Last Name: \(lastName ?? "")"
        addressLabel.text = "Address: \(address ?? "")"
        cityLabel.text = "City: \(city ?? "")"
        stateLabel.text = "State: \(state ?? "")"
        paymentTypeLabel.text = "Payment Type: \(paymentType ?? "")"
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    @IBAction func confirmBookingButtonTapped(_ sender: UIButton) {
        // Store order details in user defaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(firstName, forKey: "firstName")
        userDefaults.set(lastName, forKey: "lastName")
        userDefaults.set(address, forKey: "address")
        userDefaults.set(city, forKey: "city")
        userDefaults.set(state, forKey: "state")
        userDefaults.set(paymentType, forKey: "paymentType")
        
        let alertController = UIAlertController(title: "Success", message: "Your booking has been confirmed.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { action in
            if let mainContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainContentViewController") {
                // You may need to adjust this part based on your navigation stack
                self.navigationController?.pushViewController(mainContentViewController, animated: true)
            }
        })
        self.present(alertController, animated: true, completion: nil)
    }

}
