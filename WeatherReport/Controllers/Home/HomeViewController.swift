//
//  HomeViewController.swift
//  WeatherReport
//
//  Created by afouzdar on 28/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableViewCities: UITableView!
    
    var arrData = [NSManagedObject]()
    
    // MARK: - Load views
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //  let data = fetchData()
       // print(data.0)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getdata()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Get data from DB
    func getdata(){
         arrData = fetchData()
        tableViewCities.reloadData()
//        for data in arrData {
//              
//             print(data.value(forKey: "name") as! String)
//              
//        }
    }
   // MARK: - Delete data from DB
    func deleteCity(data: NSManagedObject){
        let isDeleted = deleteData(dict: data)
              if(isDeleted){
                self.getdata()
        }
    }
    
    // MARK: - Button Action
    @objc func deleteCityBtnAction(sender: UIButton){
        showAlertView(title: "", message: "Are you sure you want to delete the city?", preferredStyle: .alert, okLabel: "No", cancelLabel: "Yes", targetViewController: self, isSingleAlert: false, okHandler: { (action) -> Void in
            
        }) { (action) -> Void in
            let dict = self.arrData[sender.tag]
            self.deleteCity(data: dict)
                 
        }
       
    }

    @IBAction func addCityBtnAction(_ sender: Any) {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "Map") as? Map
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    @IBAction func helpBtnAction(_ sender: Any) {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "Help") as? Help
        self.navigationController?.pushViewController(controller!, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = self.arrData[indexPath.row]
        let city = dict.value(forKey: "name") as? String
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "City") as? City
        controller?.dictCity = dict
        self.navigationController?.pushViewController(controller!, animated: true)
        
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrData.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        let data = arrData[indexPath.row]
        cell.btnDelete.tag = indexPath.row
        cell.labelCity.text = data.value(forKey: "name") as? String
            cell.btnDelete.addTarget(self, action: #selector(deleteCityBtnAction), for: .touchUpInside)
            return cell
        }
        
    }
    


