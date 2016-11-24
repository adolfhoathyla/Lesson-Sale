//
//  Local.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 15/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import Foundation
import CoreLocation

class Place {
    
    var coordinate: CLLocation!
    var address: String!
    //var number: String?
    
    init(address: String, coordinate: CLLocation){
        self.coordinate = coordinate
        self.address = address
        //self.number = number
    }
    
    
}