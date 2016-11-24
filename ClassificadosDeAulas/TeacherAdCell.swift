//
//  TeacherAdCell.swift
//  ClassificadosDeAulas
//
//  Created by Davi Freire on 29/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class TeacherAdCell: UITableViewCell {

	@IBOutlet weak var Ad: UILabel!
	
	@IBOutlet weak var dados: UITextView!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
