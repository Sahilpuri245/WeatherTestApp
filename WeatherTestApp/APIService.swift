//
//  APIService.swift
//  WeatherTestApp
//
//  Created by Sahil on 13/09/23.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    let apikeyUrl = "52460e3a27db423682e84216231309"
    var apiUrl = ""
    let baseUrl = "https://api.weatherapi.com/v1"
    var city = ""
    
    let session = URLSession(configuration: .default)
    
    func buildURL() -> String {
        apiUrl = "/current.json" + "?key=" + apikeyUrl + "&q=" + city + "&aqi=" + "no"
        return baseUrl + (apiUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
    }
    
 
    func getWeather(onSuccess: @escaping (Weather) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: buildURL()) else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Weather.self, from: data)
                        onSuccess(items)
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    
}
    
