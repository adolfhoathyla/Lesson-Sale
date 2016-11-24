//
//  Anuncio.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 15/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import Foundation

class Advertisement {
    
    var category: Category!
    var description: String!
    var place: Place!
    var equipment: String?
    var duration: String?
    var teacher: Teacher!
    
    init(category: Category,description: String,place: Place,equipment: String, duration: String, teacher: Teacher){
        
        self.category = category
        self.description = description
        self.place = place
        self.equipment = equipment
        self.duration = duration
        self.teacher = teacher
    }
}