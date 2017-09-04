//
//  ViewController.swift
//  BikeMapiOS
//
//  Created by Faizal Patel on 9/4/17.
//  Copyright © 2017 fpatel. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var city: String = ""
    var items:[String] = []
    let annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.showsUserLocation = true
        mapView.delegate = self
        
        print("city"+self.city)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let url = URL(string: "https://api.jcdecaux.com/vls/v1/stations?apiKey=38440d36615d46c21c37e5e4cfb487f6a17c9e3c&contract=\(city)") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            
            // urlRequest.addValue("apiKey", forHTTPHeaderField: "38440d36615d46c21c37e5e4cfb487f6a17c9e3c")
            
            //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            
            Alamofire.request(urlRequest).responseArray( keyPath: "",completionHandler: { (response: DataResponse<[Stations]>) in
                let forecastArray = response.result.value
                

                
                
                if let forecastArray = forecastArray {
                    for forecast in forecastArray {
                        print(forecast.name ?? "")
                        //print(forecast.lat ?? "")
                       
                        let dLati = Double(forecast.position?.lat ?? "") ?? 0.0
                        let dLong = Double(forecast.position?.lng ?? "") ?? 0.0
                        self.annotation.coordinate = CLLocationCoordinate2D(latitude: dLati
                            , longitude: dLong)
                            
                        self.mapView.addAnnotation(self.annotation)
                    }
                    
                
                    //reload the data
                  //  self.tableView.reloadData()
                    
                    
                }
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


