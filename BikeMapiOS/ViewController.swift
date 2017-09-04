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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.showsUserLocation = true
        mapView.delegate = self
        if (!city.isEmpty) {self.navigationItem.prompt = city;}
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
               // let smallSquare = CGSize(width: 30, height: 30)
              
                
                if let forecastArray = forecastArray {
                    for forecast in forecastArray {
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: (forecast.position?.lat)!
                            , longitude: (forecast.position?.lng)!)
                        
                        annotation.title = forecast.name
                  
                        
                        
                        self.mapView.addAnnotation(annotation)
                        
                        self.mapView.setCenter(annotation.coordinate, animated: true)
                    }
       
                    //reload the data
                  //  self.tableView.reloadData()
                    if(!(forecastArray.isEmpty)){
                        let initialLocation = CLLocation(latitude: forecastArray[(forecastArray.count)/2].lat!, longitude: forecastArray[(forecastArray.count)/2].lng!)
                        self.centerMapOnLocation(location: initialLocation)
                    }
                    
                }
                
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 9000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKUserLocation) {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
            
            let rightButton = UIButton(type: UIButtonType.infoLight)
            rightButton.tag = annotation.hash
            rightButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
           // pinView.image =
            pinView.animatesDrop = true
            pinView.canShowCallout = true
            pinView.rightCalloutAccessoryView = rightButton
            
            return pinView
        }
        else {
            return nil
        }
    }
    
    func buttonClicked() {
        // do something
        print("btn clicked")
        let toolBarItems = [profileButton]
        self.navigationItem.leftBarButtonItem = profileButton
        self.setToolbarItems(toolBarItems, animated: true)
    }
    
    var profileButton: UIBarButtonItem = {
        var button = UIBarButtonItem(title: "Directions", style: .plain, target: self, action: #selector(segueToProfileController(_:)))
        
        return button
    }()
    
    func segueToProfileController(_ sender: Any){
        
    }
}


