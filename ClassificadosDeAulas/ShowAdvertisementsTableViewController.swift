//
//  ShowAdvertisementsTableViewController.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 29/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class ShowAdvertisementsTableViewController: PFQueryTableViewController, CLLocationManagerDelegate {

    var objectIdCategory: String?
    
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    
    var categoryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        let buttonMap = UIBarButtonItem(title: "View in map", style: UIBarButtonItemStyle.Done, target: self, action: Selector("actionGoToMap"))
        
        self.navigationItem.rightBarButtonItem = buttonMap

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Configure the PFQueryTableView
        self.parseClassName = "Advertisement"
        self.textKey = "title"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Advertisement")
        query.orderByAscending("title")
        query.whereKey("category", equalTo: PFObject(withoutDataWithClassName: "Category", objectId: objectIdCategory))
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CellAd") as! CellAdTableViewCell!
        if cell == nil {
            cell = CellAdTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CellAd")
        }
        
        // Extract values from the PFObject to display in the table cell
        if let title = object?["title"] as? String, place = object?["place"] as? PFObject, objectId = place.objectId {
            
            
            let query = PFQuery(className: "Place")
            query.getObjectInBackgroundWithId(objectId, block: { (place, error) -> Void in
                if error == nil {
                    
                    if let address = place?["address"] as? String, coordinates = place?["coordinates"] as? PFGeoPoint {

                        cell.adAddress.text = address

                        let latitude = coordinates.valueForKey("latitude") as? CLLocationDegrees
                        let longitude = coordinates.valueForKey("longitude") as? CLLocationDegrees
                        
                        let coordinatesV = CLLocation(latitude: latitude!, longitude: longitude!)
                        
                        let meters = coordinatesV.distanceFromLocation(self.currentLocation)
                        
                        let km = meters / 1000
                        
                        cell.distance.text = String(format: "%1.2f km", km)
                    }
                }
            })
            
            cell?.adTitle?.text = title
            cell.objectId = object?.objectId
            
            if let category = categoryName {
                switch category {
                case "Concursos":
                    cell?.adImage.image = UIImage(named: "iconConcursos")
                    break
                case "Culinária":
                    cell?.adImage.image = UIImage(named: "iconCulinaria")
                    break
                case "Dança":
                    cell?.adImage.image = UIImage(named: "iconDanca")
                    break
                case "Escolar":
                    cell?.adImage.image = UIImage(named: "iconEscolar")
                    break
                case "Fitness":
                    cell?.adImage.image = UIImage(named: "iconFitness")
                    break
                case "Futebol":
                    cell?.adImage.image = UIImage(named: "iconFutebol")
                    break
                case "Línguas":
                    cell?.adImage.image = UIImage(named: "iconLinguas")
                    break
                case "Música":
                    cell?.adImage.image = UIImage(named: "iconMusica")
                    break
                case "Tecnologia":
                    cell?.adImage.image = UIImage(named: "iconTecnologia")
                    break
                case "Outros":
                    cell?.adImage.image = UIImage(named: "iconOutros")
                    break
                default:
                    break
                }
            }

            
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCategory") as! HeaderCategoryTableViewCell
        cell.textHeader.text = self.categoryName
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? CellAdTableViewCell
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let advertisementVC = mainStoryboard.instantiateViewControllerWithIdentifier("TeacherProfileAndAd") as? TeacherProfileAndAd
        
        advertisementVC?.objectId = cell?.objectId
        
        self.navigationController?.pushViewController(advertisementVC!, animated: true)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        currentLocation = locations.last as? CLLocation
        
    }

    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            break
        case .Denied:
            break
        case .NotDetermined:
            break
        case .Restricted:
            break
        case .AuthorizedAlways:
            break
        }
    }

    func actionGoToMap() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = mainStoryboard.instantiateViewControllerWithIdentifier("MapViewSearchAdsViewController") as! MapSearchAdsViewController
        
        mapVC.objectIdCategory = objectIdCategory
        mapVC.categoryName = categoryName
        
        self.navigationController?.pushViewController(mapVC, animated: true)
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
