//
//  categoryTableView.swift
//  ClassificadosDeAulas
//
//  Created by Davi Freire on 17/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

//import Cocoa


class categoryTableView: PFQueryTableViewController {
    
//    override func viewDidLoad() {
//        tableView.tableFooterView = UIView()
//        tableView.reloadData()
//    }

	// Initialise the PFQueryTable tableview
	override init(style: UITableViewStyle, className: String!) {
		super.init(style: style, className: className)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
  
		// Configure the PFQueryTableView
		self.parseClassName = "Category"
		self.textKey = "name"
		self.pullToRefreshEnabled = true
		self.paginationEnabled = false
	}
	
	//Nessa parte iremos configurar os dados que teram REFRESH no server
	// Define the query that will provide the data for the table view
	
	override func queryForTable() -> PFQuery {
		var query = PFQuery(className: "Category")
		query.orderByAscending("name")
		//caso se queira restringir o retorno do data SET
		//query.whereKey("currencyCode", equalTo:"EUR")
		
		return query
	}
	
	
	//override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
		
		var cell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as! CategoryCell!
		if cell == nil {
			cell = CategoryCell(style: UITableViewCellStyle.Default, reuseIdentifier: "categoryCell")
		}
		
		// Extract values from the PFObject to display in the table cell
		if let name = object?["name"] as? String {
			cell?.categoryName?.text = name
            cell?.qtdAds.text = "oi"
            
            switch name {
                case "Concursos":
                    cell?.categoryFlag.image = UIImage(named: "iconConcursos")
                break
                case "Culinária":
                    cell?.categoryFlag.image = UIImage(named: "iconCulinaria")
                break
                case "Dança":
                    cell?.categoryFlag.image = UIImage(named: "iconDanca")
                break
                case "Escolar":
                    cell?.categoryFlag.image = UIImage(named: "iconEscolar")
                break
                case "Fitness":
                    cell?.categoryFlag.image = UIImage(named: "iconFitness")
                break
                case "Futebol":
                    cell?.categoryFlag.image = UIImage(named: "iconFutebol")
                break
                case "Línguas":
                    cell?.categoryFlag.image = UIImage(named: "iconLinguas")
                break
                case "Música":
                    cell?.categoryFlag.image = UIImage(named: "iconMusica")
                break
                case "Tecnologia":
                    cell?.categoryFlag.image = UIImage(named: "iconTecnologia")
                break
                case "Outros":
                    cell?.categoryFlag.image = UIImage(named: "iconOutros")
                break
            default:
                break
            }
            
			
		}
		
		if let object = object, let objectId = object.objectId {
			cell?.objectId = objectId
			//println(objectId)
		}
        
        
		
		return cell
	}
	
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewAdsVC = mainStoryboard.instantiateViewControllerWithIdentifier("ViewAds") as? ShowAdvertisementsTableViewController
        
        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell {
            viewAdsVC?.objectIdCategory = cell.objectId
            viewAdsVC?.categoryName = cell.categoryName.text
        }
        
        self.navigationController?.pushViewController(viewAdsVC!, animated: true)
        
	}
	
//	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//		
//		var subcategoryScene = segue.destinationViewController as! ViewAdvertisementTableViewController
//        
//		if let indexPath = self.tableView.indexPathForSelectedRow() {
//			let row = Int(indexPath.row)
//			if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? CategoryCell {
//                subcategoryScene.objectIdCategory = cell.objectId
//			}
//		}
//	}

}
