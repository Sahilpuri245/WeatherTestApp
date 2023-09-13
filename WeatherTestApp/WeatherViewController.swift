//
//  WeatherViewController.swift
//  WeatherTestApp
//
//  Created by Sahil on 13/09/23.
//

import UIKit

import MapKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    
    var locationManger: CLLocationManager!
    var currentlocation: CLLocation?
    var weatherResult: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
            self.getLocation()
       
    }
    func getWeather() {
        APIService.shared.getWeather(onSuccess: {[weak self] (result) in
            guard let self = self else {
                return
            }
            self.weatherResult = result
            print(result)
            DispatchQueue.main.async {
                self.dateTimeLabel.text = "Date and Time:" + (result.location?.localtime ?? "")
                self.cityLabel.text =  "City:" + (result.location?.name ?? "")
                self.tempratureLabel.text = "Temperature:" +  String(result.current?.temp_c ?? 0)
                self.humidityLabel.text = "Humidity:" +  String(result.current?.humidity ?? 0)
                self.windSpeedLabel.text = "Wind Speed:" +  String(result.current?.wind_kph ?? 0)
                   
            }
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    
    func getLocation() {
       
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestWhenInUseAuthorization()
            locationManger.requestLocation()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentlocation = location
            
            let latitude: Double = self.currentlocation!.coordinate.latitude
            let longitude: Double = self.currentlocation!.coordinate.longitude
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        if let city = placemark.locality {
                            print(city)
                            APIService.shared.city = city
                            self.getWeather()
                        }
                    }
                }
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    @IBAction func getCurrentLocationTapped(_ sender: UIButton) {
        getLocation()
    }
    
    @IBAction func NextTapped(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController else {
            return
        }
        vc.result = weatherResult
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

