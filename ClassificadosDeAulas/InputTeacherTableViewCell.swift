//
//  InputTeacherTableViewCell.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 17/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class InputTeacherTableViewCell: UITableViewCell {

    @IBOutlet var requiredField: UILabel!
    @IBOutlet var input: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
