//
//  MainContentViewController.swift
//  Assignment3
//  Created by Chenjun Zheng on 25/5/2023.

import UIKit

// MainContentViewController handles the main interface for the application
class MainContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    @IBOutlet weak var tableView: UITableView!

    // The original dataset
    var data = [Car]()

    // Indicate whether the data has been sorted
    var isSorted = Bool(false)

    // Search controller for car searching
    var searchController: UISearchController!

    // A dataset filtered by the search controller
    var filteredData = [Car]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup table view
        tableView.dataSource = self
        tableView.delegate = self
        data = CarData.shared.originalData

        // Setup search controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cars"
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        self.navigationItem.setHidesBackButton(true, animated: false)

        // Setup navigation bar buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort Price", style: .plain, target: self, action: #selector(sortPrice))
    }

    // Function of "Sort Price"
    @objc func sortPrice(_ sender: UIBarButtonItem) {
        isSorted.toggle()
        if isSorted {
            orderByPrice()
        } else {
            resetOriginalOrder()
        }
        tableView.reloadData() // Refresh the table view to reflect the sorting change
    }

    func orderByPrice() {
        data.sort { $0.price < $1.price }
        if isFiltering() {
            filteredData.sort { $0.price < $1.price }
        }
    }

    func resetOriginalOrder() {
        data = CarData.shared.originalData
        if isFiltering() {
            resetFilteredDataToMatchSearchTerm()
        }
    }

    func resetFilteredDataToMatchSearchTerm() {
        filteredData = CarData.shared.originalData.filter { (car: Car) -> Bool in
            return car.title.lowercased().contains(searchController.searchBar.text!.lowercased())
        }
    }


    // Function of logOut
    @IBAction func logOut(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.searchBar.sizeToFit()
    }

    // Depending on whether or not the table view is filtering, return the number of rows in the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredData.count : data.count
    }

    // Populate each cell in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let car = isFiltering() ? filteredData[indexPath.row] : data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {
            fatalError("The dequeued cell is not a CustomTableViewCell object.")
        }
        cell.label.text = "\(car.title) - $\(car.price)"
        cell.iconImageView.image = UIImage(named: car.imageName) ?? UIImage(named: "defaultImage")
        return cell
    }

    // Handle selection of a row in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = isFiltering() ? filteredData[indexPath.row] : data[indexPath.row]
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CarDetailViewController") as! CarDetailViewController
        detailVC.car = car
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    // Update the search results when the search text changes
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(searchBar.text!)
    }

    //function for data filtering based on user-entered search terms
    func filterContent(_ searchText: String) {
        
        //Remove line breaks and spaces from the search text
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //The original data is used if the search string is empty and no filtering procedure is carried out.
        guard !trimmedSearchText.isEmpty else {
            filteredData = data
            tableView.reloadData()
            return
        }
        
        //Filter the car data to locate any records where the search term appears in the title.
        filteredData = data.filter { (car: Car) -> Bool in
            return car.title.lowercased().contains(trimmedSearchText.lowercased())
        }
        
        tableView.reloadData()
    }


    // Determine if the search bar is currently active and filtering
    func isFiltering() -> Bool {
        return searchController.isActive && !checkSearchBarEmpty()
    }

    // Determine that the search field is now empty.
    func checkSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}
