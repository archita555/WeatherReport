//
//  Location.swift
//  WeatherReport
//
//  Created by afouzdar on 30/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import UIKit
import MapKit

class Location: NSObject,CLLocationManagerDelegate {
    
    static let shared = Location()
    let locationManager = CLLocationManager()
    
    var currentLatitude: Double = 0.0
    var currentLongitude: Double = 0.0
    
    
    //MARK: -CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // The user denied authorization
            
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            // The user accepted authorization
            //  self.getCurrentAddress()
            print("allowed...")
        
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last! as CLLocation
        currentLatitude = Double(location.coordinate.latitude)
        currentLongitude = Double(location.coordinate.longitude)
        
    }
    


}
