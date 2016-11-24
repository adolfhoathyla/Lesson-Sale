//
//  SubcategoryTableView.swift
//  ClassificadosDeAulas
//
//  Created by Davi Freire on 21/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

//import Cocoa

class SubcategoryTableView: PFQueryTableViewController {
	
	//var currentObject : PFObject?
    var objectId: String?
	
	// Initialise the PFQueryTable tableview
	override init(style: UITableViewStyle, className: String!) {
		super.init(style: style, className: className)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
  
		// Configure the PFQueryTableView
		self.parseClassName = "Subcategory"
		self.textKey = "name"
		self.pullToRefreshEnabled = true
		self.paginationEnabled = false
		
	}
    
//    override func viewDidLoad() {
//        tableView.tableFooterView = UIView()
//    }
	
	
	//Nessa parte iremos configurar os dados que teram REFRESH no server
	// Define the query that will provide the data for the table view
	
//	override func queryForTable() -> PFQuery {
//		//var obj = PFObject(withoutDataWithObjectId: categoryId!)
//		
//		var query = PFQuery(className: "Subcategory")
//		
//		//caso se queira restringir o retorno do data SET
//		
//		//query.whereKey("category", equalTo:obj)
//		
//		
////		query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
////			
////			if error==nil{
////				
////				println(results)
////				
////			}
////		}
//		query.orderByAscending("name")
//		//query.selectKeys(["name"])
//		
//		return query
//		
//	}
	
	override func queryForTable() -> PFQuery {
//		var queryCategory = PFQuery(className: "Category")
//		queryCategory.whereKey("objectId", equalTo: categoryId!)
//		var object: PFObject = PFObject(withoutDataWithClassName: "Category", objectId: categoryName!)
		
		
		//categoryPointer = String(format: "%p", arguments: categoryId!)
		var query = PFQuery(className: "Subcategory")
		//query.whereKey("categoryName", equalTo: categoryName!)
        
        if let objId = objectId {
            query.whereKey("category", equalTo: PFObject(withoutDataWithClassName: "Category", objectId: objId))
        }
        
		query.orderByAscending("name")
		
		return query
	}
	
	
	//override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
		
		var cell = tableView.dequeueReusableCellWithIdentifier("SubcategoryCell") as! SubcategoryCell!
		if cell == nil {
			cell = SubcategoryCell(style: UITableViewCellStyle.Default, reuseIdentifier: "SubcategoryCell")
		}
		
		// Extract values from the PFObject to display in the table cell
		if let name = object?["name"] as? String {
			cell?.subcategoryName?.text = name
			cell?.subcategoryFlag.image = UIImage(named: "teste")
			
		}
        
        if let object = object, let objectId = object.objectId {
            cell.objectId = objectId
        }
		
		return cell
	}
	
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? SubcategoryCell
        let objid = cell?.objectId
        
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mapViewController = storyboard.instantiateViewControllerWithIdentifier("MapViewSearchAdsViewController") as? MapSearchAdsViewController
        mapViewController?.objectIdCategory = objid
        self.navigationController?.pushViewController(mapViewController!, animated: true)
	}


}
