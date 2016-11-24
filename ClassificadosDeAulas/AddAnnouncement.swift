//
//  AddAnnouncement.swift
//  ClassificadosDeAulas
//
//  Created by Davi Freire on 28/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class AddAnnouncement: UITableViewController {
	
	override func viewDidLoad() {
		let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Done, target: self, action: Selector("actionNext"))
        
        self.navigationItem.rightBarButtonItem = nextButton
        
        tableView.tableFooterView = UIView()
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
	
		var cell: UITableViewCell!
		
		
		if indexPath.row == 0 {
			cell = tableView.dequeueReusableCellWithIdentifier("cell1") as! AddAnnouncementCell1!
		}
		if indexPath.row == 1{
			cell = tableView.dequeueReusableCellWithIdentifier("cell2") as! AddAnnoucementCell2!

		}

		
		return cell
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// #warning Potentially incomplete method implementation.
		// Return the number of sections.
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete method implementation.
		// Return the number of rows in the section.
		return 2
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		
		if indexPath.row == 1 {
			return 300.0
		}
	
		return 50.0
	}
	
	override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 25.0
	}
	
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableCellWithIdentifier("HeaderEquipment") as! HeaderEquipmentTableViewCell
        
        return header
        
    }
    
    func actionNext() {
        
        let cellTitle = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! AddAnnouncementCell1
        let title = cellTitle.titleAnnouncement.text
        
        let cellEquipment = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0)) as! AddAnnoucementCell2
        
        let needEquipment = cellEquipment.equipment.on
        
        var equipments = ""
        if needEquipment {
            equipments = cellEquipment.equipmentDescription.text
        } else {
            equipments = "Nothing"
        }
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let descriptionVC = mainStoryboard.instantiateViewControllerWithIdentifier("DescriptionViewController") as! DescriptionTableViewController
        
        descriptionVC.titleAd = title
        descriptionVC.equipment = equipments
        
        self.navigationController?.pushViewController(descriptionVC, animated: true)
        
    }

}
