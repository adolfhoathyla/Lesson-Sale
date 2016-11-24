//
//  MapSearchAdsViewController.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 22/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit
import MapKit

class MapSearchAdsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView!
    
    var locationManager: CLLocationManager!
    
    var objectIdCategory: String!
    var categoryName: String!
    
    var ads = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = categoryName
        
        self.initMyMap()
        
        if let obj = self.objectIdCategory {
            println(obj)
            
            let query = PFQuery(className: "Advertisement")
            query.whereKey("category", equalTo: PFObject(withoutDataWithClassName: "Category", objectId: objectIdCategory))
            
            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                self.ads = (objects as? [PFObject])!
                self.addAllAdvertisements()
                
            })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initMyMap() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        myMap.delegate = self
        myMap.setUserTrackingMode(.Follow, animated: true)
        
    }
    
    private func addAllAdvertisements() {
        
        for ad in ads {
            
            let adAnnotation = AnnotationAdvertisement()
            
            if let place = ad["place"] as? PFObject, objectId = place.objectId {
                
                let query = PFQuery(className: "Place")
                query.getObjectInBackgroundWithId(objectId, block: { (placeResult, error) -> Void in
                    
                    if error == nil {
                        
                        if let address = placeResult?["address"] as? String, coordinates = placeResult?["coordinates"] as? PFGeoPoint {
                            
                            let latitude = coordinates.valueForKey("latitude") as? CLLocationDegrees
                            let longitude = coordinates.valueForKey("longitude") as? CLLocationDegrees
                            
                            adAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                            
                            adAnnotation.title = ad["title"] as? String
                            adAnnotation.subtitle = address
                            
                            adAnnotation.objectId = ad.objectId
                            
                            self.myMap.addAnnotation(adAnnotation)
                            
                        }
                        
                    }
                    
                })
            }
            
            
            
            
        }
        
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        var adAnnotation = myMap.dequeueReusableAnnotationViewWithIdentifier("adAnnotation")
        
        //precisa de uma imagem! Senão o pino não apareceu
        if adAnnotation == nil {
            adAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: "adAnnotation")
            adAnnotation.image = UIImage(named: "pin")
        }
        
        adAnnotation.annotation = annotation
        adAnnotation.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView
        
        adAnnotation.canShowCallout = true
        
        return adAnnotation
        
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        
        let adAnnotation = view.annotation as? AnnotationAdvertisement
        
        if control == view.rightCalloutAccessoryView {
            println("ObjectId: \(adAnnotation?.objectId)")
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVc = mainStoryboard.instantiateViewControllerWithIdentifier("TeacherProfileAndAd") as? TeacherProfileAndAd
            
            detailVc?.objectId = adAnnotation?.objectId
            
            self.navigationController?.pushViewController(detailVc!, animated: true)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
