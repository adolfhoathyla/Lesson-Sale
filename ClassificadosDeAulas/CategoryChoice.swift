//
//  CategoryChoice.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 25/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class CategoryChoice: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var picker: UIPickerView!
    
    var categoryArray = [PFObject]()
    
    var adDescription: String?
    var adTitle: String?
    var adEquipments: String?
    var place: Place?
    var adDuration: String?
    
    var category: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Title: \(adTitle)")
        println("Description: \(adDescription)")
        println("Equipments: \(adEquipments)")
        println("Place: \(place?.address)")
        println("Duration: \(adDuration)")
        
        let nextButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("actionDone"))
        
        self.navigationItem.rightBarButtonItem = nextButton
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        let blockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        blockView.backgroundColor = UIColor.blackColor()
        blockView.alpha = 0.5
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        blockView.addSubview(spinner)
        
        self.view.addSubview(blockView)
        
        ParseHelper.queryAllCategories { (categories, error) -> () in
            
            if error == nil{
                
                if let categories = categories{
                    
                    spinner.stopAnimating()
                    blockView.removeFromSuperview()
                    
                    self.categoryArray = categories
                    self.category = self.categoryArray.first
                    self.picker.reloadAllComponents()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var rows = 0
        
        if component == 0 {
            
            rows = categoryArray.count
        }
        
        return rows
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        
        var cellName = ""
        
        if component == 0 {
            
            cellName = (categoryArray[row]["name"] as? String)!
        }
        
        return cellName
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0{
            
            category = categoryArray[row]
            
        }
    }
    
    func actionDone() {
        
        let blockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        blockView.backgroundColor = UIColor.blackColor()
        blockView.alpha = 0.5
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        blockView.addSubview(spinner)
        
        self.view.addSubview(blockView)
        
        if let address = place?.address, coordinate = place?.coordinate {
            ParseHelper.addPlace(address, coordinates: coordinate) { (place) -> () in
                
                ParseHelper.addAdvertisement(self.category!, teacher: PFUser.currentUser()!, place: place!, title: self.adTitle!, desc: self.adDescription!, equipment: self.adEquipments!, duration: self.adDuration!, completionBlock: { (advertisement) -> () in
                    
                    spinner.stopAnimating()
                    blockView.removeFromSuperview()
                    
                    println("Anúncio criado com sucesso: \(advertisement!.objectId)")
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let perfilVC = mainStoryboard.instantiateViewControllerWithIdentifier("ProfileTeacherViewController") as! TeacherProfile
                    self.navigationController?.pushViewController(perfilVC, animated: true)
                    
                })
                
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
