//
//  ShowListAdsCell.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 29/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class ShowListAdsCell: PFTableViewCell {
    
    @IBOutlet var imageCategory: UIImageView!
    @IBOutlet weak var titleAds: UILabel!
    @IBOutlet weak var placeAds: UITextView!
    var objectId: String!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
