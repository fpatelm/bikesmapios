//
//  Stations.swift
//  BikeMapiOS
//
//  Created by Faizal Patel on 9/5/17.
//  Copyright © 2017 fpatel. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class Stations : Mappable{
    var position : Position?
    var name : String?
    var lat : Double?
    var lng : Double?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        position <- map["position"]
        lat <- map["position.lat"]
        lng <- map["position.lng"]
    }
}

struct Position : Mappable{
    var lat : Double?
    var lng : Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}


