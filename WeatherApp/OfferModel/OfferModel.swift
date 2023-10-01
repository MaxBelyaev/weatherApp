//
//  OfferModel.swift
//  WeatherApp
//
//  Created by Максим Беляев on 09.10.2023.
//

import Foundation

class OfferModel:Codable {
    var cod: String?
    var massage: Float?
    var cnt: Float
    var list: [ListOfferModel]?
    var city: CityModel?
}
