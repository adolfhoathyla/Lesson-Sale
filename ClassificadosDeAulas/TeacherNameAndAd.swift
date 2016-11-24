//
//  TeacherNameAndAdTableViewCell.swift
//  ClassificadosDeAulas
//
//  Created by Davi Freire on 29/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//


import UIKit

class TeacherNameAndAd: UITableViewCell {
	
	@IBOutlet weak var teacherImage: UIImageView!
	

	@IBOutlet weak var teacherName: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
		self.teacherImage.frame.origin.y -= CGFloat(100.0)
		
		self.teacherImage.layer.cornerRadius = self.teacherImage.frame.size.width / 2
		self.teacherImage.layer.masksToBounds = true
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
