//
//  CarData.swift
//  Assignment3
//
//  Created by Chenjun Zheng on 25/5/2023.
//

class CarData {
    static let shared = CarData()
    
    var originalData: [Car] = [
        Car(title: "BMW", imageName: "BMW", description: "The sporty and elegant cars from the German luxury car maker are dedicated to delivering a distinctive driving experience.", price: 150),
        Car(title: "Volkswagen", imageName: "Volkswagen", description: "The core company and founding brand of the Volkswagen Group, its best-selling brand, and the largest automaker in the world is Volkswagen, a car manufacturing company based in Wolfsburg, Germany.", price: 100),
        Car(title: "Mercedes-Benz", imageName: "Mercedes-Benz", description: "One of the most prestigious automakers in the world, Mercedes-Benz is renowned for its technical excellence, high standards of quality, inventiveness, and variety of classic coupé models.", price: 180),
        Car(title: "Tesla", imageName: "Tesla", description: "American electric vehicle manufacturer Tesla is renowned for its cutting-edge electric technology, autonomous driving capabilities, and dedication to the future of sustainable mobility.", price: 170),
        Car(title: "Audi", imageName: "Audi", description: "A perfect fusion of technology and superb craftsmanship, Audi is a German luxury car manufacturer with a worldwide reputation for excellent craftsmanship, innovative design, and an exceptional driving experience.", price: 190),
        Car(title: "Toyota Prius", imageName: "Toyota Prius", description: "One of the world's most popular hybrid cars is the Prius. It is renowned for its efficient hybrid drivetrain, excellent fuel economy, and ground-breaking design. Its hybrid powertrain, which combines an internal combustion engine and an electric motor, provides a comfortable, effective ride.", price: 110),
        Car(title: "Honda Accord Hybrid", imageName: "Honda Accord Hybrid", description: "A well-known hybrid car that offers exceptional driving comfort and the best fuel efficiency is the Honda Accord Hybrid. It features Honda's ground-breaking hybrid technology, which combines two powerful electric motors with an effective gasoline engine to deliver remarkable performance and acceleration.", price: 140),
        Car(title: "Nissan Leaf", imageName: "Nissan Leaf", description: "One of the most popular electric automobiles on the market today is the Nissan LEAF. It is favoured for its usefulness, comfort, and exceptional range. The LEAF offers a driving experience that is equivalent to that of a conventional gasoline vehicle despite being an all-electric vehicle.", price: 120),
    ]
    
    private init() { }
}

