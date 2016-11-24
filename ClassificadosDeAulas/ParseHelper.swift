//
//  ParseHelper.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 16/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

class ParseHelper {
   
    //MARK: -FunctionsTeacher
    
    //Function add Teacher in our Store
    static func addTeacher(username: String, password: String, name: String, email: String?, phone: String, curriculum: String, imagePerfil: UIImage, completionBlock: (teacher: PFUser?, error: NSError?) -> ()) {
        
        var teacher = PFUser()
        
        teacher.username = username
        teacher.password = password
        teacher.email = email
        
        teacher["phone"] = phone
        teacher["curriculum"] = curriculum
        teacher["name"] = name
        
        let imagePerfilData = UIImagePNGRepresentation(imagePerfil)
        let imagePerfilFile = PFFile(data: imagePerfilData)
        
        teacher["imagePerfil"] = imagePerfilFile
        
        teacher.signUpInBackgroundWithBlock { (sucess, error) -> Void in
            
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
                println("ops: \(errorString)")
                completionBlock(teacher: nil, error: error)
            } else {
                println("User saved with id: \(teacher.objectId)")
                completionBlock(teacher: teacher, error: nil)
            }
            
        }
        
    }
    
    //Function edit user informations. Ops: just user logged
    static func editTeacherLogged(name: String, phone: String, email: String, curriculum: String, imageProfile: UIImage, completionBlock: (error: NSError?) -> ()) {
        let currentUser = PFUser.currentUser()
        
        if currentUser != nil {
            currentUser?.email = email
            currentUser?["phone"] = phone
            currentUser?["name"] = name
            currentUser?["curriculum"] = curriculum
            
            let imageProfileData = UIImagePNGRepresentation(imageProfile)
            let imageProfileFile = PFFile(data: imageProfileData)
            
            currentUser?["imagePerfil"] = imageProfileFile
            
            
            currentUser?.saveInBackgroundWithBlock({ (success, error) -> Void in
                
                if success {
                    println("Usuário editado com sucesso")
                    completionBlock(error: nil)
                } else {
                    println("Erro ao editar professor")
                    completionBlock(error: error)
                }
                
            })
            
        }
    }
    
    //Function verify if have user's session
    static func haveCurrentUser(completionBlock: (user: PFUser?) -> ()) {
        var currentUser = PFUser.currentUser()
        if currentUser != nil {
            println("Current user is: \(currentUser?.username)")
            completionBlock(user: currentUser)
        } else {
            println("Don't have current user")
            completionBlock(user: nil)
        }
    }
    
    //Function login
    static func loggingIn(username: String, password: String, completionBlock: (user: PFUser?, error: NSError?) -> ()) {
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            
            if user != nil {
                println("Success login with \(user?.username)")
                completionBlock(user: user, error: error)
            } else {
                println("Ops: \(error)")
                completionBlock(user: nil, error: error)
            }
            
        }
    }
    
    //Function retrieve Teacher for objectId
    static func queryTeacher(objectId: String, completionBlock: (user: PFObject?) -> ()) {
        var query = PFQuery(className: "_User")
        query.getObjectInBackgroundWithId(objectId, block: { (object, error) -> Void in
            
            let name = object?.objectForKey("name") as? String
            
            if error == nil {
                println("Object Teacher \(name) retrieved")
                completionBlock(user: object)
            } else {
                println("Ops: \(error)")
                completionBlock(user: nil)
            }
            
        })
    }
    
    //Function retrieve Teacher for name
    static func queryTeacherForName(name: String, completionBlock: (user: PFUser?) -> ()) {
        
        var query = PFQuery(className: "_User", predicate: NSPredicate(format: "name BEGINSWITH %@", name))
        
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            
            if error == nil {
                if let teacher: AnyObject = result?.first {
                    let name = teacher["name"] as? String
                    println("Teacher \(name) found")
                    completionBlock(user: teacher as? PFUser)
                }
            } else {
                println("Ops: \(error)")
                completionBlock(user: nil)
            }
            
        }
    }
    
    //MARK: - FunctionsPlace
    
    //Function add Place
    static func addPlace(address: String, coordinates: CLLocation, completionBlock: (place: PFObject?) -> ()) {
        
        var place = PFObject(className: "Place")
        place.setObject(address, forKey: "address")
        
        let location = PFGeoPoint(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
        place.setObject(location, forKey: "coordinates")
        
        place.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                println("Object Place saved with id: \(place.objectId)")
                completionBlock(place: place)
            } else {
                println("Ops: \(error)")
                completionBlock(place: nil)
            }
            
        }
    }
    
    //Function retrieve Place for objectId
    static func queryPlace(objectId: String, completionBlock: (place: PFObject?) -> ()) {
        var query = PFQuery(className: "Place")
        query.getObjectInBackgroundWithId(objectId, block: { (object, error) -> Void in
            
            let address = object?.objectForKey("address") as? String
            
            if error == nil {
                println("Object Place \(address) retrieved")
                completionBlock(place: object!)
            } else {
                println("Ops: \(error)")
                completionBlock(place: nil)
            }
            
        })
    }
    
    //Function retrieve Place for name
    static func queryPlaceForAddress(address: String, completionBlock: (place: PFObject?) -> ()) {
        var query = PFQuery(className: "Place", predicate: NSPredicate(format: "address BEGINSWITH %@", address))
        
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            
            if error == nil {
                if let place: AnyObject = result?.first {
                    let addressV = place["address"] as? String
                    println("Place \(addressV) found")
                    completionBlock(place: place as? PFObject)
                }
            } else {
                println("Ops: \(error)")
                completionBlock(place: nil)
            }
            
        }
    }
    
    //MARK: - FunctionsCategory
    
    //Function add Category
    static func addCategory(name: String, completionBlock: (category: PFObject?) -> ()) {
        
        var category = PFObject(className: "Category")
        category.setObject(name, forKey: "name")
        
        category.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                println("Object category saved with id: \(category.objectId)")
                completionBlock(category: category)
            } else {
                println("Ops: \(error)")
                completionBlock(category: nil)
            }
        }
    }
    
    //Function retrieve Category for objectId
    static func queryCategory(objectId: String, completionBlock: (category: PFObject?) -> ()) {
        var query = PFQuery(className: "Category")
        query.getObjectInBackgroundWithId(objectId, block: { (object, error) -> Void in
            
            let name = object?.objectForKey("name") as? String
            
            if error == nil {
                println("Object Category \(name) retrieved")
                completionBlock(category: object)
            } else {
                println("Ops: \(error)")
                completionBlock(category: nil)
            }
            
        })
    }
    
    //Function retrieve Category for name
    static func queryCategoryForName(name: String, completionBlock: (category: PFObject?) -> ()) {
        var query = PFQuery(className: "Category", predicate: NSPredicate(format: "name BEGINSWITH %@", name))
        
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            
            if error == nil {
                if let categoryV: AnyObject = result?.first {
                    let name = categoryV["name"] as? String
                    println("Category \(name) found")
                    completionBlock(category: categoryV as? PFObject)
                }
            } else {
                println("Ops: \(error)")
                completionBlock(category: nil)
            }
            
        }
    }
    
    //Function return all objects of Category
    static func queryAllCategories(completionBlock: (categories: [PFObject]?, error: NSError?) -> ()) {
        var query = PFQuery(className: "Category")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                completionBlock(categories: (objects as? [PFObject]), error: nil)
            } else {
                completionBlock(categories: nil, error: error)
            }
            
        }
    }
    
    
    //MARK: - FunctionsSubcategories
    
    //Function add Subcategories
    static func addSubcategory(name: String, category: PFObject, completionBlock: (subcategory: PFObject?) -> ()) {
        
        var subcategory = PFObject(className: "Subcategory")
        subcategory.setObject(name, forKey: "name")
        subcategory.setObject(category, forKey: "category")
        
        subcategory.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                println("Object Subcategory saved with id: \(subcategory.objectId)")
                completionBlock(subcategory: subcategory)
            } else {
                println("Ops: \(error)")
                completionBlock(subcategory: nil)
            }
            
        }
        
    }
    
    //Function retrieve Subcategory for objectId
    static func querySubcategory(objectId: String, completionBlock: (subcategory: PFObject?) -> ()) {
        var query = PFQuery(className: "Subcategory")
        query.getObjectInBackgroundWithId(objectId, block: { (object, error) -> Void in
            
            let name = object?.objectForKey("name") as? String
            
            if error == nil {
                println("Object subcategory \(name) retrieved")
                completionBlock(subcategory: object)
            } else {
                println("Ops: \(error)")
                completionBlock(subcategory: nil)
            }
            
        })
    }
    
    //Function retrieve Subcategory for name
    static func querySubcategoryForName(name: String, completionBlock: (subcategory: PFObject?) -> ()) {
        var query = PFQuery(className: "Subcategory", predicate: NSPredicate(format: "name BEGINSWITH %@", name))
        
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            
            if error == nil {
                if let subcategoryV: AnyObject = result?.first {
                    let name = subcategoryV["name"] as? String
                    println("Subcategory \(name) found")
                    completionBlock(subcategory: subcategoryV as? PFObject)
                }
            } else {
                println("Ops: \(error)")
                completionBlock(subcategory: nil)
            }
            
        }
    }
    
    //Function return all subcategories for the category
    static func querySubcategoriesForCategory(category: PFObject?, completionBlock: (subcategories: [PFObject]?, error: NSError?) -> ()) {
        
        var query = PFQuery(className: "Subcategory")
        query.whereKey("category", equalTo: category!)
        
        query.findObjectsInBackgroundWithBlock { (subcategories, error) -> Void in
            if error == nil {
                completionBlock(subcategories: subcategories as? [PFObject], error: nil)
            } else {
                completionBlock(subcategories: nil, error: error!)
            }
        }
        
    }
    
    //MARK: - FunctionsAdvertisement
    
    //Function add Ad
    static func addAdvertisement(category: PFObject, teacher: PFObject, place: PFObject, title: String, desc: String, equipment: String, duration: String, completionBlock: (advertisement: PFObject?) -> ()) {
        
        var advertisement = PFObject(className: "Advertisement")
        
        advertisement.setObject(category, forKey: "category")
        advertisement.setObject(teacher, forKey: "teacher")
        advertisement.setObject(place, forKey: "place")
        
        advertisement.setObject(title, forKey: "title")
        advertisement.setObject(desc, forKey: "description")
        advertisement.setObject(equipment, forKey: "equipment")
        advertisement.setObject(duration, forKey: "duration")
        
        advertisement.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                println("Object Advertisement saved with id: \(advertisement.objectId)")
                completionBlock(advertisement: advertisement)
            } else {
                println("ops: \(error)")
                completionBlock(advertisement: nil)
            }
            
        }
        
    }
    
    //Function retrieve Advertisement for objectId
    static func queryAdvertisement(objectId: String, completionBlock: (advertisement: PFObject?) -> ()) {
        var query = PFQuery(className: "Advertisement")
        query.getObjectInBackgroundWithId(objectId, block: { (object, error) -> Void in
            
            let title = object?.objectForKey("title") as? String
            
            if error == nil {
                println("Object Advertisement \(title) retrieved")
                completionBlock(advertisement: object)
            } else {
                println("Ops: \(error)")
                completionBlock(advertisement: nil)
            }
            
        })
    }
    
    //Function retrieve Advertisement for name
    static func queryAdvertisementForTitle(title: String, completionBlock: (advertisement: PFObject?) -> ()) {
        var query = PFQuery(className: "Advertisement", predicate: NSPredicate(format: "title BEGINSWITH %@", title))
        
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            
            if error == nil {
                if let ad: AnyObject = result?.first {
                    let title = ad["name"] as? String
                    println("Category \(title) found")
                    completionBlock(advertisement: ad as? PFObject)
                }
            } else {
                println("Ops: \(error)")
                completionBlock(advertisement: nil)
            }
            
        }
    }
    
    
}
