//
//  CarDetailViewController.swift
//  Assignment3
//
//  Created by Chenjun Zheng on 25/5/2023.
//

import Foundation
import UIKit
class CarDetailViewController: UIViewController {
    var car: MainContentViewController.Car?
    @IBOutlet weak var carDescription: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var carDetailImageView: UIImageView!
    override func viewDidLoad() {
           super.viewDidLoad()
           
        if let car = car {
            carDetailImageView.image = UIImage(named: car.imageName)
            carDescription.text = car.description
            priceLabel.text = String(format: "$%.2f per day", car.price)
            }
       }


}
