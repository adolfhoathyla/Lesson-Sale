//
//  Teacher.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 15/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import Foundation

class Teacher {
    
    var name: String!
    var phone: String!
    var email: String!
    //var photo
    var description : String!
    
    init(name: String, phone: String, email: String, description: String){
        
        self.name = name
        self.phone = phone
        self.email = email
        self.description = description
    }
}