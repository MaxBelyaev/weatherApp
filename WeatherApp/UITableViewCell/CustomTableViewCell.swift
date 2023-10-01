//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by Максим Беляев on 14.10.2023.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var citylabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    override var reuseIdentifier: String? {
        return "CustomTableViewCell"
    }
        
    
    
}
