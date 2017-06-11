//
//  AppDelegate.swift
//  BikeMapiOS
//
//  Created by Faizal Patel on 03/06/2017.
//  Copyright © 2017 fpatel. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var item :[String]? = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // get the default headers
        
        // v
        
        
        if let url = URL(string: "https://feeds.citibikenyc.com/stations/stations.json") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            
           // urlRequest.addValue("apiKey", forHTTPHeaderField: "38440d36615d46c21c37e5e4cfb487f6a17c9e3c")
         
            //urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            let def = UserDefaults.standard
          
            Alamofire.request(urlRequest).responseArray( keyPath: "stationBeanList",completionHandler: { (response: DataResponse<[ContractResponse]>) in
                let forecastArray = response.result.value
         
                print(response.request)
                print(response.result.error)
                if let forecastArray = forecastArray {
                    for forecast in forecastArray {
                       // print(forecast.name ?? "")
                        self.item?.append(forecast.name!)
                     
                        
                    }
                    
                    for uu in self.item! {
                       print(uu ?? "")
                    }
                    
                    def.setValue(self.item, forKey: "ListStations")
                  
                }
            })

  
            
        }
         return true
  
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

