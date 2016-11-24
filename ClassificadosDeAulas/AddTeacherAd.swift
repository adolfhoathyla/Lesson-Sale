//
//  AddTeacherAd.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 23/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class AddTeacherAd: UITableViewCell {
    
    @IBOutlet weak var AddTeacherAd: UIButton!
    @IBOutlet weak var seeTableAds: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        AddTeacherAd.layer.cornerRadius = 8.0
        AddTeacherAd.clipsToBounds = true
        seeTableAds.layer.cornerRadius = 8.0
        seeTableAds.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
