//
//  Weather.swift
//  WeatherTestApp
//
//  Created by Sahil on 13/09/23.
//

import Foundation
struct Weather:Codable {
let location:Location?
let current: Current?
}

struct Location:Codable {
    var name: String?
    var region:String?
    var country:String?
    var lat:Double?
    var lon:Double?
    var localtime: String?
    
}

struct Current:Codable {
    var temp_c: Double?
    var temp_f:Double?
    var wind_mph:Double?
    var wind_kph:Double?
    var wind_degree:Int?
    var wind_dir: String?
    var pressure_mb:Double?
    var humidity: Double?
    var cloud: Double?
    var condition:Condition?
    
}

struct Condition:Codable {
    var text:String?
    var icon:String?
    var code: Int?
}
