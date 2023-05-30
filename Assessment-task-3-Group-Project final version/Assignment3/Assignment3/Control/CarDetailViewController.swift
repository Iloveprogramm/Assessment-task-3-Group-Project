//
//  CarDetailViewController.swift
//  Assignment3
//  Created by Chenjun Zheng on 25/5/2023.


import Foundation
import UIKit

class CarDetailViewController: UIViewController {
    var car: Car?
    @IBOutlet weak var carDescription: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var carDetailImageView: UIImageView!
    
    @IBOutlet weak var bookButton: UIButton! // Book Button
    
    // View count dictionary
    static var viewCount: [String: Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        if let car = car {
            carDetailImageView.image = UIImage(named: car.imageName)
            carDescription.text = car.description
            priceLabel.text = String(format: "$%.2f per day", car.price)

            // Increase the view count and update the title
            CarDetailViewController.viewCount[car.title, default: 0] += 1
            self.title = "\(car.title) (viewed \(CarDetailViewController.viewCount[car.title]!) times)"
        }
    }

    // Book Button function
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        let checkoutVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CheckoutViewController") as! CheckoutViewController
        checkoutVC.car = car
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }
}
