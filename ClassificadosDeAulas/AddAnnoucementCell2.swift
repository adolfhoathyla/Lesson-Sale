//
//  AddAnnoucementCell2.swift
//  ClassificadosDeAulas
//
//  Created by Davi Freire on 28/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//



class AddAnnoucementCell2: UITableViewCell {
	
	@IBOutlet weak var equipment: UISwitch!
	
	@IBAction func equipmentSwitch(sender: UISwitch) {
		if sender.on {
			equipmentDescription.hidden = false
            equipmentDescription.becomeFirstResponder()
		}else{
			equipmentDescription.hidden = true
            equipmentDescription.resignFirstResponder()
		}
		
	}
	
	
	@IBOutlet weak var equipmentDescription: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        equipment.on = false
        equipmentDescription.hidden = true
        
    }

}
