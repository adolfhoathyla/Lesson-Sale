//
//  RequestGoogleGeocoding.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 23/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import CoreLocation
import UIKit

class RequestGoogleGeocoding {
   
    static func makeRequest(search: String, completionBlock: (status: String, addresses: [Place]?) -> ()) {
        
        let url = "http://maps.googleapis.com/maps/api/geocode/json?address=\(search)&sensor=true&region=br"
        let urlUTF8 = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let request = NSMutableURLRequest(URL: NSURL(string: urlUTF8!)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (reponse, data, error) -> Void in
            
            let response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: nil) as? NSDictionary
            
            let status = response?.valueForKey("status") as! String
            
            if status == "OK" {
                
                let result = response?.valueForKey("results") as! NSArray
                
                let addresses = result.valueForKey("formatted_address") as! NSArray
                
                let locations = result.valueForKey("geometry")?.valueForKey("location") as! NSArray
                let latitudes = locations.valueForKey("lat") as! NSArray
                let longitudes = locations.valueForKey("lng") as! NSArray
                
                var addressPlaces = [Place]()
                
                for var i = 0; i < addresses.count; i++ {
                    
                    let lat = latitudes[i] as! CLLocationDegrees
                    let lgn = longitudes[i] as! CLLocationDegrees
                    
                    let place = Place(address: (addresses[i] as? String)!, coordinate: CLLocation(latitude: lat, longitude: lgn))
                    
                    addressPlaces.append(place)
                    
                    completionBlock(status: status, addresses: addressPlaces)
                
                }
                
            } else if status == "ZERO_RESULTS" {
                
                completionBlock(status: status, addresses: nil)
                
            } else {
                println("Ocorreu algum erro na request")
                completionBlock(status: "erro", addresses: nil)
            }
            
        }
    }
    
}
