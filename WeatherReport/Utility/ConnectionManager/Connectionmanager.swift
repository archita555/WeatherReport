//
//  Connectionmanager.swift
//  WeatherReport
//
//  Created by afouzdar on 30/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import UIKit

class Connectionmanager: NSObject {

    class func callAPI(_ api: String,url: String, completionhandler:@escaping (Any,Int) -> ()){
        
       // var request = URLRequest(url: URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=0&lon=0&appid=fae7190d7e6433ec3a45285ffcf55c86&units=metric")!)
     //   request.httpMethod = "GET"
      //  request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
      //  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let finalUrl: String = baseUrl + api
        let url = URL(string: finalUrl)!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            print(response!)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(response)")
              return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                completionhandler(json,httpResponse.statusCode)
            } catch {
                print("error")
            }
        })

        task.resume()
    }
}
