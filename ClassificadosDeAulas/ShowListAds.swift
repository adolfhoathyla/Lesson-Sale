//
//  ShowListAds.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 29/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class ShowListAds: PFQueryTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        query.whereKey("teacher", equalTo: PFUser.currentUser()!)
        
        return query
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("showListAds") as! ShowListAdsCell!
        if cell == nil {
            cell = ShowListAdsCell(style: UITableViewCellStyle.Default, reuseIdentifier: "showListAds")
        }
        
        // Extract values from the PFObject to display in the table cell
//        if let title = object?["title"] as? String {
//            
//            cell?.titleAds?.text = title
//        }
        
        if let title = object?["title"] as? String, place = object?["place"] as? PFObject, objectId = place.objectId {
            
            let query = PFQuery(className: "Place")
            query.getObjectInBackgroundWithId(objectId, block: { (place, error) -> Void in
                if error == nil {
                    
                    if let address = place?["address"] as? String {
                        
                        cell?.placeAds?.text = address
                        cell?.placeAds?.editable = false
                    }
                }
            })
            
            if let category = object?["category"] as? PFObject, objectId = category.objectId {
                let query = PFQuery(className: "Category")
                query.getObjectInBackgroundWithId(objectId, block: { (category, error) -> Void in
                    
                    if error == nil {
                        
                        if let categoryName = category?["name"] as? String {
                            switch categoryName {
                            case "Concursos":
                                cell?.imageCategory.image = UIImage(named: "iconConcursos")
                                break
                            case "Culinária":
                                cell?.imageCategory.image = UIImage(named: "iconCulinaria")
                                break
                            case "Dança":
                                cell?.imageCategory.image = UIImage(named: "iconDanca")
                                break
                            case "Escolar":
                                cell?.imageCategory.image = UIImage(named: "iconEscolar")
                                break
                            case "Fitness":
                                cell?.imageCategory.image = UIImage(named: "iconFitness")
                                break
                            case "Futebol":
                                cell?.imageCategory.image = UIImage(named: "iconFutebol")
                                break
                            case "Línguas":
                                cell?.imageCategory.image = UIImage(named: "iconLinguas")
                                break
                            case "Música":
                                cell?.imageCategory.image = UIImage(named: "iconMusica")
                                break
                            case "Tecnologia":
                                cell?.imageCategory.image = UIImage(named: "iconTecnologia")
                                break
                            case "Outros":
                                cell?.imageCategory.image = UIImage(named: "iconOutros")
                                break
                            default:
                                break
                            }
                        }
                        
                    }
                    
                })
            }
            
            cell?.titleAds?.text = title
        }
        
        if let objectId = object!.objectId {
            cell?.objectId = objectId
            //println(objectId)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 85.0
        }
        
        return 85.0
    }
    
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        if section == 0{
//            
//            return "Choice the Ad"
//        }
//        
//        return nil
//    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderListAds") as? HeaderListAds
        
        headerCell?.textHeader.text = "Choice the Ad"
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewAdsVC = mainStoryboard.instantiateViewControllerWithIdentifier("ShowAdDetail") as? ShowAdDetail
        
        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? ShowListAdsCell {
            viewAdsVC?.adTitle = cell.titleAds.text
            viewAdsVC?.objectIdAdvertisement = cell.objectId
        }
        
        self.navigationController?.pushViewController(viewAdsVC!, animated: true)
        
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
