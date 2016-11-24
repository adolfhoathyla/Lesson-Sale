//
//  TeacherCell.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 22/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class TeacherCell: UITableViewCell {

    
    @IBOutlet weak var teacherName: UITextView!
    
    @IBOutlet weak var teacherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.teacherImage.frame.origin.y -= CGFloat(100.0)
        
        self.teacherImage.layer.cornerRadius = self.teacherImage.frame.size.width / 2
        self.teacherImage.layer.masksToBounds = true
        teacherImage.contentMode = .ScaleAspectFit
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
