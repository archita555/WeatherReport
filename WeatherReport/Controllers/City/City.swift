//
//  City.swift
//  WeatherReport
//
//  Created by afouzdar on 30/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import UIKit
import CoreData

class City: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var collectionViewForecast: UICollectionView!
    
    var forecast = (temparature: 0.0 , feelsLike: 0.0 , windSpeed: 0.0, humidity: 0 , rainChances: "" , windDeg: 0)
    var dictCity: NSManagedObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelCity.text = dictCity?.value(forKey: "name") as? String
        getCityDetails()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    // MARK: - Get city details
    func getCityDetails(){
        addLoading(view: self.view)
        let lat = dictCity?.value(forKey: "latitude") as? String
        let long = dictCity?.value(forKey: "longitude") as? String
        let api =   "\(oneDayForecast)lat=\(lat ?? "")&lon=\(long ?? "")&appid=\(apiKey)"
        
        Connectionmanager.callAPI(api, url: baseUrl) { (result,statusCode) in
            print(result)
        DispatchQueue.main.async {
            removeLoading(view: self.view)
        }
                     print(result)
                 
                     if result is Error {
                         let response = result as! Error
                         if((response)._code == -1009) {
                             commonAlert(title: "", msg: "Network Connection is appear to be offline.", curView: self)
                         }else{
                             print(response)
                            // commonAlert(title: "", msg: "Please try later...", curView: self)
                         }
                     }else{ // Not Error
                     
                     switch statusCode {
                     case 200:
                        
                         if result is NSDictionary{
                         let response = result as! NSDictionary
                            self.getDetails(dict: response)
                             
                         }else{
                           // commonAlert(title: "", msg: "Something went wrong!", curView: self)
                         }
                     
                     default:
                        print("error")
                        // commonAlert(title: "", msg: "Sorry can't proceess your request.Please try again!", curView: self)
                     }
                 }
                 
            }
        
    }
    
    func getDetails(dict: NSDictionary){
        if let dictWind = dict.value(forKey: "wind") as? NSDictionary{
            if let degree = dictWind.value(forKey: "deg") as? Int{
                forecast.windDeg = degree
            }
            if let speed = dictWind.value(forKey: "speed") as? Double{
                forecast.windSpeed = speed
            }
        }
        if let dictMain = dict.value(forKey: "main") as? NSDictionary{
            if let humidity = dictMain.value(forKey: "humidity") as? Int{
                forecast.humidity = humidity
            }
            if let temp = dictMain.value(forKey: "temp") as? Double{
                let celsiusTemp = temp - 273.15
                forecast.temparature = celsiusTemp
            }
            
            if let feels_like = dictMain.value(forKey: "feels_like") as? Double{
                let celsiusTemp = feels_like - 273.15
                forecast.feelsLike = celsiusTemp
            }
        }
        
        if let weather = dict.value(forKey: "weather") as? NSArray{
            let dictWeather = weather[0] as! NSDictionary
            if let description = dictWeather.value(forKey: "description") as? String{
                forecast.rainChances = description
            }
        }
        DispatchQueue.main.async {
            self.collectionViewForecast.reloadData()
        }
        
    }
    
    
}

// MARK: - UICollectionViewDataSource

extension City: UICollectionViewDataSource {
// tell the collection view how many cells to make
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
}

// make a cell for each cell index path
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityForecastCollectionViewCell", for: indexPath as IndexPath) as! CityForecastCollectionViewCell
       
    switch indexPath.row {
    case 0:
        cell.labelForecast.text = String(format: "%.2f", forecast.temparature) + " °C"
        cell.labelForecastType.text = "Temparature"
    case 1:
        cell.labelForecast.text = String(forecast.humidity) + "%"
        cell.labelForecastType.text = "Humidity"
    case 2:
        cell.labelForecast.text = String(forecast.windSpeed) + " km/h"
        cell.labelForecastType.text = "Wind Speed"
    case 3:
        cell.labelForecast.text = String(forecast.windDeg) + "°"
        cell.labelForecastType.text = "Wind Degree"
    case 4:
        cell.labelForecast.text = String(format: "%.2f", forecast.feelsLike) + " °C"
        cell.labelForecastType.text = "Feels Like"
    case 5:
        cell.labelForecast.text = forecast.rainChances
        cell.labelForecastType.text = "Rain Chance"
    default:
        break
    }
    
        return cell
    
    }
    
 }
    



// MARK: - UICollectionViewDelegate protocol
extension City: UICollectionViewDelegate {
    
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // handle tap events
    
    
 }
    
}

extension City: UICollectionViewDelegateFlowLayout {
    // MARK:- UICollectioViewDelegateFlowLayout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (collectionView.frame.width-20)/2, height: 80)
        
    }
}
