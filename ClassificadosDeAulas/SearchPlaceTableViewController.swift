//
//  SearchPlaceTableViewController.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 23/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class SearchPlaceTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var mySearchBar: UISearchBar!
    
    var adDescription: String?
    var adTitle: String?
    var adEquipments: String?
    
    var addresses = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mySearchBar.delegate = self
        
        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return addresses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellPlace", forIndexPath: indexPath) as! CellAddressTableViewCell

        cell.cellAddress.text = addresses[indexPath.row].address

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let place = addresses[indexPath.row]
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let durationVC = mainStoryboard.instantiateViewControllerWithIdentifier("DurationViewController") as! DurationViewController
        durationVC.adTitle = adTitle
        durationVC.adDescription = adDescription
        durationVC.adEquipments = adEquipments
        durationVC.place = Place(address: place.address, coordinate: place.coordinate)
        
        self.navigationController?.pushViewController(durationVC, animated: true)
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: -SearchBar
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        let blockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        blockView.backgroundColor = UIColor.blackColor()
        blockView.alpha = 0.5
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        blockView.addSubview(spinner)
        
        self.view.addSubview(blockView)
        
        //verificar se exite rede
        
        RequestGoogleGeocoding.makeRequest(searchBar.text, completionBlock: { (status, addresses) -> () in
            
            if addresses != nil {
                self.addresses = addresses!
                self.tableView.reloadData()
                
                spinner.stopAnimating()
                blockView.removeFromSuperview()
                
            } else {
                
                var title = ""
                var message = ""
                
                if status == "ZERO_RESULTS" {
                    title = "No results"
                    message = "Your request has not results"
                } else {
                    title = "Request error"
                    message = "Your request has a error"
                }
                
                spinner.stopAnimating()
                blockView.removeFromSuperview()
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            

            
        })
    }
    
}
