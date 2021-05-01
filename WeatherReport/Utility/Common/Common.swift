//
//  Common.swift
//  WeatherReport
//
//  Created by afouzdar on 29/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import Foundation
import UIKit


var loadingBackground = UIView()
var indicator = UIActivityIndicatorView()
var loadingText = UILabel()


func showAlertView(title alerTitle:String ,message alertMessage:String, preferredStyle style:UIAlertController.Style, okLabel: String, cancelLabel: String, targetViewController: UIViewController,isSingleAlert: Bool,okHandler: ((UIAlertAction?) -> Void)!, cancelHandler: ((UIAlertAction?) -> Void)!){
    
    let alertController = UIAlertController(title: alerTitle, message: alertMessage, preferredStyle: style)
    
    let okAction = UIAlertAction(title: okLabel, style: .default, handler: okHandler)
    let cancelAction = UIAlertAction(title: cancelLabel, style: .default,handler: cancelHandler)
    
    if(isSingleAlert) {
        alertController.addAction(okAction)
    } else {
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    }
    
    // Present Alert Controller
    targetViewController.present(alertController, animated: true, completion: nil)
    
}

func commonAlert(title:String,msg:String,curView:UIViewController) {
    
    let device : UIDevice = UIDevice.current;
    
    let systemVersion = device.systemVersion;
    
    let iosVerion : Float = (systemVersion as NSString).floatValue
    
    if(iosVerion >= 8.0) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        // return alert
        
        curView.present(alert, animated: true, completion: nil)
    }
}

func addLoading(view:UIView) -> Void {
    
    loadingBackground = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 70))
    indicator = UIActivityIndicatorView(style: .whiteLarge)
    indicator.color = UIColor(red: 14/255, green: 5/255, blue: 134/255, alpha: 1)//UIColor(red: 236/255, green: 56/255, blue: 81/255, alpha: 1)
    indicator.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    loadingText = UILabel(frame: CGRect(x: 0, y: 0, width: 62, height: 20))
    loadingText.font = UIFont.boldSystemFont(ofSize: 12)
    loadingText.center = CGPoint(x: view.center.x, y: view.center.y + 20)
    loadingBackground.layer.cornerRadius = 10
    loadingBackground.backgroundColor = UIColor.white
    loadingBackground.center = view.center
  //  loadingBackground.setViewShadow()
    indicator.startAnimating()
    indicator.center = view.center
    loadingText.text = "Loading..."
    loadingText.textColor = UIColor.white
    loadingText.backgroundColor = UIColor.clear
    view.addSubview(loadingBackground)
    view.addSubview(indicator)
    view.addSubview(loadingText)
    view.isUserInteractionEnabled = false
}

 func removeLoading(view:UIView) -> Void {
    loadingBackground.removeFromSuperview()
    indicator.removeFromSuperview()
    loadingText.removeFromSuperview()
    view.isUserInteractionEnabled = true
    //        loadingBackground = nil
    //        indicator = nil
    //        loadingText = nil
}


extension String {
    func isEmptyString()->Bool {
        let noWhiteSpaceOrNewLineString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (noWhiteSpaceOrNewLineString.count > 0) {
            return false
        } else {
            return true
        }
    }
}
