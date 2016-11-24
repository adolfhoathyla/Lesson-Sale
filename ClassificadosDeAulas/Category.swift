//
//  Categoria.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 15/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import Foundation

class Category {
    
    var name: String!
    var subcategory: [String]!
    
    init(name: String, subcategory: [String]){
        
        self.name = name
        self.subcategory = subcategory
    }
    
}