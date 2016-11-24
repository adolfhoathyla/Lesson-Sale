//
//  PhotoTableViewCell.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 18/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet var imagePerfil: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.imagePerfil.frame.origin.y -= CGFloat(100.0)
        
        self.imagePerfil.layer.cornerRadius = self.imagePerfil.frame.size.width / 2
        self.imagePerfil.layer.masksToBounds = true
        imagePerfil.contentMode = .ScaleAspectFit
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
