//
//  cont.swift
//  BikeMapiOS
//
//  Created by Faizal Patel on 9/5/17.
//  Copyright © 2017 fpatel. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class Cont : Mappable{
    
    var name : String?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
    }
    
}
