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
