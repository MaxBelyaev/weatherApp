//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Максим Беляев on 09.10.2023.
//

import Foundation

class NetworkManager {
    private init() {}
    
    static let shared:NetworkManager = NetworkManager()
    
    func getWeather(city:String, result: @escaping ((OfferModel?) -> ())) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/forecast"
        urlComponents.queryItems = [URLQueryItem(name: "q", value: city),
                                    URLQueryItem(name: "id", value: "524901"),
                                    URLQueryItem(name: "appid", value: "ad97ac7ff46e2679955e4c013de41929")]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        let task = URLSession(configuration: .default)
        task.dataTask(with: request) { (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                var decoderOfferModel: OfferModel?
                
                if data != nil {
                    decoderOfferModel = try? decoder.decode(OfferModel.self, from: data!)
                }
                
                result(decoderOfferModel)
            } else {
                print(error as Any)
            }
        }.resume()
    }
}
