//
//  ContractReply.swift
//  BikeMapiOS
//
//  Created by Faizal Patel on 11/06/2017.
//  Copyright © 2017 fpatel. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class ContractResponse : Mappable{
    
    var name : String?
    var availableBikes : String?
    var latitude : String?
    var longitude : String?

    
    
   
    required init?(map: Map) {
        
    }
   

    func mapping(map: Map) {
        name <- map["stationName"]
        availableBikes <- map["availableBikes"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
    }
    
}
