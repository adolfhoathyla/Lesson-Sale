//
//  ViewController.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 13/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var buttonTeacher: UIButton!
    @IBOutlet var buttonStudent: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        buttonTeacher.layer.cornerRadius = 8.0
        buttonTeacher.clipsToBounds = true
        
        buttonStudent.layer.cornerRadius = 8.0
        buttonStudent.clipsToBounds = true
        
//        ParseHelper.addTeacher("aron", password: "cebola", name: "Adolfho Athyla", email: "adolfo@gmail.com", phone: "999149603", curriculum: "Estudante de computação a 3,5 anos", imagePerfil: UIImage(named: "eu")!) { (teacher) -> () in
//            
//            let nameTeacher = teacher?.username
//            
//            println("Sucesso ao cadastrar o professor \(nameTeacher)")
//            
//        }
//
//        ParseHelper.haveCurrentUser { (user) -> () in
//            
//            let userName = user["name"] as? String
//            
//            println("Current user: \(userName)")
//        }
//        
//        ParseHelper.addCategory("Música", completionBlock: { (category) -> () in
//            
//            let categoryName = category["name"] as? String
//            println("Category: \(categoryName)")
//            
//        })
//
//        ParseHelper.addSubcategory("Violão", category: PFObject(withoutDataWithClassName: "Category", objectId: "wDgj4oRNfY")) { (subcategory) -> () in
//            
//            let subcategory = subcategory["name"] as? String
//            println("Subcategory: \(subcategory)")
//            
//        }
//
//        ParseHelper.queryCategoryForName("Música", completionBlock: { (category) -> () in
//            
//            let categoryName = category["name"] as? String
//            
//            println("Category found: \(categoryName)")
//        })
//
//        ParseHelper.querySubcategoryForName("Violão", completionBlock: { (subcategory) -> () in
//            
//            let subcategoryName = subcategory["name"] as? String
//            
//            println(subcategoryName)
//            
//        })
//        
//        ParseHelper.addPlace("IFCE Maracanaú", coordinates: CLLocation(latitude: -3.8725904, longitude: -38.6109761)) { (place) -> () in
//            
//            var address = place["address"] as? String
//            println(address)
//            
//        }
//        
//        ParseHelper.queryPlaceForAddress("IFCE", completionBlock: { (place) -> () in
//            
//            var address = place["address"] as? String
//            println(address)
//            
//        })
        
//        ParseHelper.queryAllCategories { (categories, error) -> () in
//            
//            if let categories = categories {
//                for category in categories {
//                    println(category["name"])
//                }
//            }
//
//            
//        }
        
//        ParseHelper.querySubcategoriesForCategory(PFObject(withoutDataWithClassName: "Category", objectId: "wDgj4oRNfY"), completionBlock: { (subcategories, error) -> () in
//            
//            if let subcategories = subcategories {
//                for subcategory in subcategories {
//                    println(subcategory["name"])
//                }
//            }
//            
//        })
        
        //PFUser.logOut()
        
//        ParseHelper.editTeacherLogged("Adolfho Athyla", phone: "85999149603", email: "athyla@gmail.com", curriculum: "Jogador de pedra na luaaaa!! (:") { (error) -> () in
//            
//            if error != nil {
//                println("Aconteceu esse erro: \(error)")
//            } else {
//                println("Sucesso!!!!")
//            }
//            
//        }
        
//        ParseHelper.addCategory("Culinária", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
//        
//        ParseHelper.addCategory("Concursos", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
//        
//        ParseHelper.addCategory("Dança", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
//        
//        ParseHelper.addCategory("Escolar", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
//        
//        ParseHelper.addCategory("Fitness", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
//        
//        ParseHelper.addCategory("Futebol", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
//        
//        ParseHelper.addCategory("Línguas", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
//        
//        ParseHelper.addCategory("Tecnologia", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
//        
//        ParseHelper.addCategory("Outros", completionBlock: { (category) -> () in
//            if category != nil {
//                println("Success!!!")
//            }
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionTeacher(sender: UIButton) {
        ParseHelper.haveCurrentUser { (user) -> () in
            
            if user == nil {
                println("Not existis current user")
                
                //Present view login
                let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboardMain.instantiateViewControllerWithIdentifier("LoginViewController") as? UIViewController
                self.navigationController?.pushViewController(loginVC!, animated: true)
                
            } else {
                let name = user?.username
                println("Current user is: \(name)")
                
                let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
                let PerfilVC = storyboardMain.instantiateViewControllerWithIdentifier("ProfileTeacherViewController") as? UIViewController
                self.navigationController?.pushViewController(PerfilVC!, animated: true)
            }
            
        }
    }

    @IBAction func actionStudent(sender: UIButton) {
    }
}

