//
//  ShowAdDetail.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 30/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class ShowAdDetail: PFQueryTableViewController {

    var objectIdAdvertisement: String?
    
    var adTitle: String?
    
    // Initialise the PFQueryTable tableview
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
    
    //Nessa parte iremos configurar os dados que teram REFRESH no server
    // Define the query that will provide the data for the table view
    
    override func queryForTable() -> PFQuery {
        var query = PFQuery(className: "Advertisement")
        query.orderByAscending("title")
        //query.whereKey("teacher", equalTo: PFUser.currentUser()!)
        query.whereKey("objectId", equalTo: self.objectIdAdvertisement!)
        
        //query.getObjectInBackgroundWithId(self.objectIdAdvertisement!)
        
        return query
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cellReturn: PFTableViewCell?
        
        switch indexPath.section{
            
        case 0:
                
            var cell = tableView.dequeueReusableCellWithIdentifier("AdTitle", forIndexPath: indexPath) as! AdTitle
                
            if let title = object?.valueForKey("title") as? String {
                
                cell.adTitle.text = title
            }

            cellReturn = cell
        
            break
            
        case 1:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("CategoryTitle", forIndexPath: indexPath) as! CategoryTitle
            
            if let category = object?["category"] as? PFObject, objectId = category.objectId{
                
                let query = PFQuery(className: "Category")
                query.getObjectInBackgroundWithId(objectId, block: { (category, error) -> Void in
                    if error == nil {
                        
                        if let name = category?["name"] as? String {
                            
                            cell.categoryTitle.text = name
                            println(name)
                        }
                    }
                })
            }
            cellReturn = cell
            
            break
            
        case 2:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("AdDescription", forIndexPath: indexPath) as! AdDescription
            
            if let descriptionString = object?["description"] as? String {
                
                cell.adDescription.text = descriptionString
            }
            
            cellReturn = cell
            
            break
            
        case 3:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("AdPlace", forIndexPath: indexPath) as! AdPlace
            
            if let place = object?["place"] as? PFObject, objectId = place.objectId{
                
                let query = PFQuery(className: "Place")
                query.getObjectInBackgroundWithId(objectId, block: { (place, error) -> Void in
                    if error == nil {
                        
                        if let place = place?["address"] as? String {
                            
                            cell.adPlace.text = place
                        }
                    }
                })
            }
            cellReturn = cell
            
            break
            
        case 4:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("AdDuration", forIndexPath: indexPath) as! AdDuration
            
            if let duration = object?.valueForKey("duration") as? String {
                
                cell.adDuration.text = duration
            }
            
            cellReturn = cell
            
            break
            
        case 5:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("AdMaterials", forIndexPath: indexPath) as! AdMaterials
            
            if let material = object?.valueForKey("equipment") as? String {
                
                cell.adMaterials.text = material
            }
            
            cellReturn = cell
            
            break
            
        default:
            
            break
        }
        
        return cellReturn!
    }
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return 1
//    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 6
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderShowAd") as? HeaderShowAd
        
        switch section {
        case 0:
            headerCell?.textHeaderShowAd.text = "Ad Information"
            break
        case 3:
            headerCell?.textHeaderShowAd.text = "Place"
            break
        case 4:
            headerCell?.textHeaderShowAd.text = "Duration"
            break
        case 5:
            headerCell?.textHeaderShowAd.text = "Materials"
            break
        default:
            headerCell = nil
            break
        }
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height: CGFloat?
        
        switch section {
        case 0:
            height = 25
            break
        case 1:
            height = 0
            break
        case 2:
            height = 0
            break
        case 3:
            height = 25
            break
        case 4:
            height = 25
            break
        case 5:
            height = 25
            break
        default:
            break
        }
        
        return height!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 2 {
            return 130.0
        }
        
        if indexPath.section == 3{
            return 60.0
        }
        
        if indexPath.section == 5{
            return 100.0
        }
        return 50.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var EditButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Done, target: self, action: Selector("actionEdit"))
        
        self.navigationItem.rightBarButtonItem = EditButton
        
        //println(self.objectIdAdvertisement)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionEdit(){
        
        
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
