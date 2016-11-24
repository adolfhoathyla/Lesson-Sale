//
//  DurationViewController.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 24/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class DurationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var adDescription: String?
    var adTitle: String?
    var adEquipments: String?
    var place: Place?

    @IBOutlet var mySegmented: UISegmentedControl!
    @IBOutlet var myPickerView: UIPickerView!
    
    var hours = [String]()
    var months = [String]()
    var days = [String]()
    
    var arrayUtilized = [String]()
    
    @IBOutlet var labelUnidade: UILabel!
    @IBOutlet var labelMedida: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Done, target: self, action: Selector("actionNext"))
        
        self.navigationItem.rightBarButtonItem = nextButton
        
        //popular months
        for var i = 1; i <= 24; i++ {
            months.append("\(i)")
        }
        
        //popular days
        for var i = 1; i <= 60; i++ {
            days.append("\(i)")
        }
        
        //popular hours
        for var i = 1; i <= 300; i++ {
            if i <= 50 {
                hours.append("\(i)")
            } else if (i % 5 == 0) {
                hours.append("\(i)")
            }
        }
        
        arrayUtilized = hours
        
        myPickerView.dataSource = self
        myPickerView.delegate = self
        
        labelMedida.text = mySegmented.titleForSegmentAtIndex(mySegmented.selectedSegmentIndex)
        labelUnidade.text = "1"
        
        // Do any additional setup after loading the view.
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
        return arrayUtilized.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return arrayUtilized[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let title = arrayUtilized[row]
        
        labelUnidade.text = title
        
        println(title)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func actionChangeMeasure(sender: UISegmentedControl) {
        labelMedida.text = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        
        if let title = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex) {
        
            switch title {
            case "Hours":
                myPickerView.userInteractionEnabled = true
                myPickerView.alpha = 1
                arrayUtilized = hours
                
                labelUnidade.hidden = false
                labelMedida.hidden = false
                break
            case "Days":
                myPickerView.userInteractionEnabled = true
                myPickerView.alpha = 1
                arrayUtilized = days
                
                labelUnidade.hidden = false
                labelMedida.hidden = false
                break
            case "Months":
                myPickerView.userInteractionEnabled = true
                myPickerView.alpha = 1
                arrayUtilized = months
                
                labelUnidade.hidden = false
                labelMedida.hidden = false
                break
            case "Undetermined":
                myPickerView.userInteractionEnabled = false
                myPickerView.alpha = 0.6
                
                labelUnidade.hidden = true
                labelMedida.hidden = true
                break
            default:
                break
            }
            
        }
        
        myPickerView.reloadAllComponents()
        
    }

    
    func actionNext() {
        
        let duration = labelUnidade.text! + " " + labelMedida.text!
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let categoryVC = mainStoryboard.instantiateViewControllerWithIdentifier("CategoryViewController") as! CategoryChoice
        
        categoryVC.adTitle = adTitle
        categoryVC.adDescription = adDescription
        categoryVC.adEquipments = adEquipments
        categoryVC.adDuration = duration
        categoryVC.place = place
        
        self.navigationController?.pushViewController(categoryVC, animated: true)
    }
    
}
