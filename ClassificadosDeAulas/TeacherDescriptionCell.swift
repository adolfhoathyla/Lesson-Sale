//
//  TeacherDescriptionCell.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 22/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class TeacherDescriptionCell: UITableViewCell {

    @IBOutlet weak var teacherDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
//        if selected {
//            teacherDescription.becomeFirstResponder()
//        } else {
//            teacherDescription.resignFirstResponder()
//        }
    }

}
