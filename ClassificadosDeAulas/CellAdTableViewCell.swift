//
//  CellAdTableViewCell.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 29/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class CellAdTableViewCell: PFTableViewCell {

    @IBOutlet var adImage: UIImageView!
    
    @IBOutlet var adTitle: UILabel!
    @IBOutlet var adAddress: UITextView!
    @IBOutlet var distance: UILabel!
    
    var objectId: String!
	var objectIdTeacher: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
