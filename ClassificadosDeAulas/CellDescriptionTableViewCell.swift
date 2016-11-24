//
//  CellDescriptionTableViewCell.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 28/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class CellDescriptionTableViewCell: UITableViewCell {

    @IBOutlet var textViewDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textViewDescription.becomeFirstResponder()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
