//
//  Constants.swift
//  WeatherReport
//
//  Created by afouzdar on 30/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Storyboards
let mainStoryboard:UIStoryboard           = UIStoryboard(name: "Main", bundle: nil)
let commonStoryboard:UIStoryboard         = UIStoryboard(name: "Common", bundle: nil)

//MARK: -BASE URLs
let baseUrl     =     "http://api.openweathermap.org/data/2.5/"


// MARK: - APIs
let oneDayForecast               = "weather?"
let fiveDayForecast              = "forecast?"

// MARK: - API KEY
 let apiKey                     = "fae7190d7e6433ec3a45285ffcf55c86"

// MARK: - Help Page Content
let webContent = "Weather, everybody wants to know how it is going to be during the week. Will it be rainy, windy,or sunny?. You can use this  App to get the weather report of the day. Just launch the App and you can see the Home Screen, in the top right corner click on the plus button which will navigate you to the Map screen, you can add your desired city just by dragging the pin on the Map and then click on ADD button. You can see all the added citied in the home screen. You can click any city you added and find out the Weather Report of the day!"
let content = "<html><body><p><strong><font size=30>" + webContent + "</font></strong></p></body></html>"
