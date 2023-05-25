//
//  MainContentViewController.swift
//  Assignment3
//
//  Created by Chenjun Zheng on 25/5/2023.
//

import UIKit

class MainContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    @IBOutlet weak var tableView: UITableView!

    struct Car {
        let title: String
        let imageName: String
        let description: String
        let price: Double
    }
    
    let data: [Car] = [
            Car(title: "BMW", imageName: "BMW", description: "The sporty and elegant cars from the German luxury car maker are dedicated to delivering a distinctive driving experience.", price: 150),
            Car(title: "Volkswagen", imageName: "Volkswagen", description: "The core company and founding brand of the Volkswagen Group, its best-selling brand, and the largest automaker in the world is Volkswagen, a car manufacturing company based in Wolfsburg, Germany.", price: 100),
            Car(title: "Mercedes-Benz", imageName: "Mercedes-Benz", description: "One of the most prestigious automakers in the world, Mercedes-Benz is renowned for its technical excellence, high standards of quality, inventiveness, and variety of classic coupé models.", price: 200),
            Car(title: "Tesla", imageName: "Tesla", description: "American electric vehicle manufacturer Tesla is renowned for its cutting-edge electric technology, autonomous driving capabilities, and dedication to the future of sustainable mobility.", price: 200),
            Car(title: "Audi", imageName: "Audi", description: "A perfect fusion of technology and superb craftsmanship, Audi is a German luxury car manufacturer with a worldwide reputation for excellent craftsmanship, innovative design, and an exceptional driving experience.", price: 200),
        ]
    var searchController: UISearchController!
    var filteredData: [Car] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cars"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.searchBar.sizeToFit()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredData.count : data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let car = isFiltering() ? filteredData[indexPath.row] : data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = car.title
        cell.iconImageView.image = UIImage(named: car.imageName)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = isFiltering() ? filteredData[indexPath.row] : data[indexPath.row]
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CarDetailViewController") as! CarDetailViewController
        detailVC.car = car
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }

    func filterContentForSearchText(_ searchText: String) {
        filteredData = data.filter { (car: Car) -> Bool in
            return car.title.lowercased().contains(searchText.lowercased())
        }
    
        tableView.reloadData()
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }

    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}
