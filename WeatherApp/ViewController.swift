//
//  ViewController.swift
//  WeatherApp
//
//  Created by Максим Беляев on 01.10.2023.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource {
    var timer = Timer()
    fileprivate var contentView: MainView {
        return self.view as! MainView
    }

    var dataIsReady: Bool = false
    var offerModel: OfferModel! {
        didSet {
            DispatchQueue.main.async {
                self.contentView.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        self.view = MainView()
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        (self.view as! MainView).tableView.dataSource = self
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationItem.title = "Погода"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = true
        
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
    }
    
    //MARK: - UISearchResultUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        let city = searchController.searchBar.text!
        timer.invalidate()
        
        if city.count > 1 {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                NetworkManager.shared.getWeather(city: city, result: { (model) in
                    if model != nil {
                        self.dataIsReady = true
                        self.offerModel = model
                    }
                })
            })
        }
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataIsReady {
            return self.offerModel!.list!.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        
        cell.citylabel.text = self.offerModel.city!.name
        cell.timeLabel.text = self.offerModel.list![indexPath.row].dt_txt
        
        if let kelvinTemp = self.offerModel.list![indexPath.row].main?.temp {
            let celsiusTemp = kelvinTemp - 273.15
            cell.tempLabel.text = String(format: "%.1f °C", celsiusTemp)
        } else {
            cell.tempLabel.text = "N/A"
        }
        
        if let kelvinMinTemp = self.offerModel.list![indexPath.row].main?.temp_min {
            let celsiusMinTemp = kelvinMinTemp - 273.15
            cell.tempMinLabel.text = String(format: "Min: %.1f °C", celsiusMinTemp)
        } else {
            cell.tempMinLabel.text = "Min: N/A"
        }
        
        if let kelvinMaxTemp = self.offerModel.list![indexPath.row].main?.temp_max {
            let celsiusMaxTemp = kelvinMaxTemp - 273.15
            cell.tempMaxLabel.text = String(format: "Max: %.1f °C", celsiusMaxTemp)
        } else {
            cell.tempMaxLabel.text = "Max: N/A"
        }
        
        
//        cell.tempMinLabel.text = self.offerModel.list![indexPath.row].main!.temp_min!.description
//        cell.tempLabel.text = self.offerModel.list![indexPath.row].main!.temp!.description
//        cell.tempMaxLabel.text = self.offerModel.list![indexPath.row].main!.temp_max!.description
        return cell
    }
}

