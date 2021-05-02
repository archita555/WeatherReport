//
//  Map.swift
//  WeatherReport
//
//  Created by afouzdar on 28/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import UIKit
import MapKit

class Map: UIViewController,MKMapViewDelegate {

    // MARK: - Outlets
    @IBOutlet weak var viewMap: MKMapView!
    
    // MARK: - variables
    var name = String()
    var latitude = String()
    var longitude = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // centerMapOnLocation(CLLocation(latitude: 17, longitude: 78), mapView: viewMap)
       loadMap()
        
    }
    
   // MARK: - Load Map
    func loadMap(){
        viewMap.delegate = self
        let location = MKPointAnnotation()
        location.coordinate = CLLocationCoordinate2D(latitude: Location.shared.currentLatitude, longitude: Location.shared.currentLongitude)
        let region = MKCoordinateRegion(
                 center: location.coordinate,
                 latitudinalMeters: 50000,
                 longitudinalMeters: 60000)
        viewMap.setCameraBoundary(
                 MKMapView.CameraBoundary(coordinateRegion: region),
                 animated: true)
        viewMap.addAnnotation(location)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        viewMap.setCameraZoomRange(zoomRange, animated: true)
               
              
               
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Button Actions
    @IBAction func addAction(_ sender: Any) {
        let arrData = fetchData()
        for data in arrData {
        let cityName = data.value(forKey: "name") as? String
            if(cityName == self.name){
                let message = name + " is already bookmarked!"
              commonAlert(title: "", msg: message, curView: self)
              return
            }
        
       }
        
        
        
        
        
        let isInvalidName = isNullString(inputString: self.name)
        
        if(!isInvalidName && !(name.isEmptyString())){
            showAlertView(title: "", message: "Are you sure you want to add the city?", preferredStyle: .alert, okLabel: "No", cancelLabel: "Yes", targetViewController: self, isSingleAlert: false, okHandler: { (action) -> Void in
                
            }) { (action) -> Void in
                
                insertData(name: self.name, latitude: self.latitude, longitude: self.longitude)
                self.navigationController?.popViewController(animated: true)
                     
            }
        }else{
            commonAlert(title: "", msg: "Please choose a valid location!", curView: self)
        }
        
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.isDraggable = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState){
        if(newState == .ending){
            print(view.annotation?.title as Any)
            print( mapView.annotations.description)
            self.latitude = String(view.annotation?.coordinate.latitude ?? 0)
            self.longitude = String(view.annotation?.coordinate.longitude ?? 0)
            getLocation(lat: view.annotation?.coordinate.latitude ?? 0, long: view.annotation?.coordinate.longitude ?? 0)
            
        }
        
    }
    
    
    
    // MARK: - Get location name
    func getLocation(lat: CLLocationDegrees , long: CLLocationDegrees){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)

        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in

            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]

            // Address dictionary
          //  print(placeMark.addressDictionary as Any)
            let address = "\(placeMark?.subThoroughfare ?? ""), \(placeMark?.thoroughfare ?? ""), \(placeMark?.locality ?? ""), \(placeMark?.subLocality ?? ""), \(placeMark?.administrativeArea ?? ""), \(placeMark?.postalCode ?? ""), \(placeMark?.country ?? "")"
            print("\(address)")

            // Location name
            if let locationName = placeMark?.name! as NSString? {
              //  self.name = locationName as String
            }

            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                print(street)
            }

            // City
            if let city = placeMark.locality! as NSString? {
                print(city)
                self.name = city as String
            }

            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                print(zip)
            }

            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                print(country)
            }

        })
    }

}
