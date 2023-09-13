//
//  WeatherDetailViewController.swift
//  WeatherTestApp
//
//  Created by Sahil on 13/09/23.
//

import Foundation
import UIKit
class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    var result: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dateTimeLabel.text = "Date and Time:" + (result.location?.localtime ?? "")
        self.cityLabel.text =  "City:" + (result.location?.name ?? "")
        self.tempratureLabel.text = "Temperature:" +  String(result?.current?.temp_c ?? 0)
        self.humidityLabel.text = "Humidity:" +  String(result?.current?.humidity ?? 0)
        self.windSpeedLabel.text = "Wind Speed:" +  String(result.current?.wind_kph ?? 0)
           
       
    }
    
}
