//
//  CategoryCell.swift
//  ClassificadosDeAulas
//
//  Created by Davi Freire on 17/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

//import Cocoa

class CategoryCell: PFTableViewCell {

	@IBOutlet weak var categoryName: UILabel!
	@IBOutlet weak var categoryFlag: UIImageView!
    @IBOutlet var qtdAds: UILabel!
	var objectId: String!
	
	
}
