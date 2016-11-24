//
//  CurriculumTableViewCell.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 18/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class CurriculumTableViewCell: UITableViewCell {

    @IBOutlet var curriculumTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
