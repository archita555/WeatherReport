//
//  Data.swift
//  WeatherReport
//
//  Created by afouzdar on 29/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

func insertData(name: String,latitude: String, longitude: String){
    
    
    let context = appDelegate.persistentContainer.viewContext

    let entity = NSEntityDescription.entity(forEntityName: "Cities", in: context)
    let newData = NSManagedObject(entity: entity!, insertInto: context)

    if !(name.isEmptyString()) {
       newData.setValue(name, forKey: "name")
    }
    if !(latitude.isEmptyString()) {
       newData.setValue(latitude, forKey: "latitude")
    }
    if !(longitude.isEmptyString()) {
       newData.setValue(longitude, forKey: "longitude")
    }
    /*
   do {
      try context.save()
     } catch {
      print("Failed saving")
   }
 */
    appDelegate.saveContext()
}

func fetchData() -> [NSManagedObject] {
    let context = appDelegate.persistentContainer.viewContext
    
    var arrData = [NSManagedObject]()
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
    
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        arrData = result as! [NSManagedObject]
        for data in result as! [NSManagedObject] {
            
         //  print(data.value(forKey: "name") as! String)
         //   name = data.value(forKey: "name") as! String
         //   lat = data.value(forKey: "latitude") as! String
         //   long  = data.value(forKey: "longitude") as! String
      }
        
    } catch {
        
        print("Failed")
    }
    return arrData
}

func deleteData(dict: NSManagedObject) -> Bool{
    
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cities")
    
    request.returnsObjectsAsFaults = false
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            if data == dict{
                context.delete(data)
                appDelegate.saveContext()
                return true
            }
         //  print(data.value(forKey: "name") as! String)
         //   name = data.value(forKey: "name") as! String
         //   lat = data.value(forKey: "latitude") as! String
         //   long  = data.value(forKey: "longitude") as! String
      }
        
    } catch {
        
        print("Failed")
        return false
    }
    
    return false
}


