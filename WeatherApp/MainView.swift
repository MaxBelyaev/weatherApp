//
//  MainView.swift
//  WeatherApp
//
//  Created by Максим Беляев on 09.10.2023.
//

import Foundation
import UIKit

class MainView: UIView {
    var tableView = UITableView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.firstInitializaton()
        self.setupConstrains()
    }
    
    fileprivate func firstInitializaton() {
        self.addSubview(tableView)
        
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }
    
    fileprivate func setupConstrains () {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
