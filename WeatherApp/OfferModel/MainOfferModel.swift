//
//  MainOfferModel.swift
//  WeatherApp
//
//  Created by Максим Беляев on 09.10.2023.
//

import Foundation

class MainOfferModel: Codable {
    var temp: Float?
    var temp_min: Float?
    var temp_max: Float?
    
    var celsiusTemp: Float? {
        if let kelvinTemp = temp {
            return kelvinTemp - 273.15
        }
        return nil
    }
    
    var celsiusMinTemp: Float? {
        if let kelvinMinTemp = temp_min {
            return kelvinMinTemp - 273.15
        }
        return nil
    }
    
    var celsiusMaxTemp: Float? {
        if let kelvinMaxTemp = temp_max {
            return kelvinMaxTemp - 273.15
        }
        return nil
    }
}
