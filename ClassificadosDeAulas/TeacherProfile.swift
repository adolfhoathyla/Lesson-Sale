//
//  TeacherProfile.swift
//  ClassificadosDeAulas
//
//  Created by Aron Uchoa Bruno on 25/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class TeacherProfile: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var person = PFUser()
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        tableView.tableFooterView = UIView()
        
        picker.delegate = self
        
        let newBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("actionLogout"))
        self.navigationItem.setLeftBarButtonItem(newBarButton, animated: true)
        
        //Looks for single or multiple taps.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        tableView.allowsSelection = false
        
        var EditButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Done, target: self, action: Selector("actionEdit"))
        
        self.navigationItem.rightBarButtonItem = EditButton
        
        self.tableView.delegate = self
        
        ParseHelper.haveCurrentUser { (user) -> () in
            
            if user != nil{
                
                self.person = user!
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func actionEdit(){
        
        if(self.navigationItem.rightBarButtonItem?.title == "Edit"){
            
            let newBarButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("actionCancel"))
            self.navigationItem.setLeftBarButtonItem(newBarButton, animated: true)
            
            self.navigationItem.rightBarButtonItem?.title = "Save"
            
            var pathName = NSIndexPath(forRow: 0, inSection: 0)
            tableView.cellForRowAtIndexPath(pathName)
            var cellName = tableView.cellForRowAtIndexPath(pathName) as! TeacherCell
            cellName.teacherName.editable = true
            
            let gesture = UITapGestureRecognizer(target: self, action: Selector("actionImage:"))
            gesture.numberOfTapsRequired = 1
            println(gesture.locationInView(self.view))
            cellName.teacherImage.addGestureRecognizer(gesture)
            cellName.teacherImage.userInteractionEnabled = true
            
            var pathPhone = NSIndexPath(forRow: 0, inSection: 1)
            tableView.cellForRowAtIndexPath(pathPhone)
            var cellPhone = tableView.cellForRowAtIndexPath(pathPhone) as! TecherPhoneCell
            cellPhone.teacherPhone.editable = true
            
            var pathEmail = NSIndexPath(forRow: 0, inSection: 2)
            tableView.cellForRowAtIndexPath(pathEmail)
            var cellEmail = tableView.cellForRowAtIndexPath(pathEmail) as! TeacherEmailCell
            cellEmail.teacherEmail.editable = true
            
            var pathDescription = NSIndexPath(forRow: 0, inSection: 3)
            tableView.cellForRowAtIndexPath(pathDescription)
            var cellDescription = tableView.cellForRowAtIndexPath(pathDescription) as! TeacherDescriptionCell
            cellDescription.teacherDescription.editable = true
        }
        else if(self.navigationItem.rightBarButtonItem?.title == "Save"){
            
            var pathName = NSIndexPath(forRow: 0, inSection: 0)
            tableView.cellForRowAtIndexPath(pathName)
            var cellName = tableView.cellForRowAtIndexPath(pathName) as! TeacherCell
            cellName.teacherName.editable = false
            
            cellName.teacherImage.userInteractionEnabled = false
            
            var pathPhone = NSIndexPath(forRow: 0, inSection: 1)
            tableView.cellForRowAtIndexPath(pathPhone)
            var cellPhone = tableView.cellForRowAtIndexPath(pathPhone) as! TecherPhoneCell
            cellPhone.teacherPhone.editable = false
            
            var pathEmail = NSIndexPath(forRow: 0, inSection: 2)
            tableView.cellForRowAtIndexPath(pathEmail)
            var cellEmail = tableView.cellForRowAtIndexPath(pathEmail) as! TeacherEmailCell
            cellEmail.teacherEmail.editable = false
            
            var pathDescription = NSIndexPath(forRow: 0, inSection: 3)
            tableView.cellForRowAtIndexPath(pathDescription)
            var cellDescription = tableView.cellForRowAtIndexPath(pathDescription) as! TeacherDescriptionCell
            cellDescription.teacherDescription.editable = false
            
            let newBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("actionLogout"))
            self.navigationItem.setLeftBarButtonItem(newBarButton, animated: true)
            
            let newImage = cellName.teacherImage.image
            
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            
            let blockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            blockView.backgroundColor = UIColor.blackColor()
            blockView.alpha = 0.5
            
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            
            spinner.center = view.center
            
            spinner.startAnimating()
            
            blockView.addSubview(spinner)
            
            self.view.addSubview(blockView)
            
            ParseHelper.editTeacherLogged(cellName.teacherName.text, phone: cellPhone.teacherPhone.text, email: cellEmail.teacherEmail.text, curriculum: cellDescription.teacherDescription.text, imageProfile: newImage!, completionBlock: { (error) -> () in
                
                if error == nil {
                    spinner.stopAnimating()
                    blockView.removeFromSuperview()
                    
                    let alert = UIAlertController(title: "Success", message: "Your profile was updating successfully", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    
                    if let errorMessage = error?.userInfo!["error"] as? String {
                        let alert = UIAlertController(title: "Error :/", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                    
                }
                
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            
            return "Profile"
        }
        if section == 1{
            
            return "Personal Information"
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 185.0
        }
        
        if indexPath.section == 3{
            return 120.0
        }
        return 50.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderTeacher") as? HeaderTeacherTableViewCell
        
        switch section {
        case 0:
            headerCell?.labelHeader.text = "Profile"
            break
        case 1:
            headerCell?.labelHeader.text = "Personal Information"
            break
        default:
            headerCell = nil
            break
        }
        
        return headerCell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height: CGFloat?
        
        switch section {
        case 0:
            height = 25
            break
        case 1:
            height = 25
            break
        case 2:
            height = 0
            break
        case 3:
            height = 0
            break
        case 4:
            height = 0
            break
        default:
            break
        }
        
        return height!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cellReturn:UITableViewCell?
        
        switch indexPath.section{
            
            
        case 0:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("teacherCell", forIndexPath: indexPath) as! TeacherCell
            
            
            if let name = person.valueForKey("name") as? String{
                
                cell.teacherName.userInteractionEnabled = true
                cell.teacherName.editable = false
                cell.teacherName.showsVerticalScrollIndicator = true
                cell.teacherName.scrollEnabled = true
                cell.teacherName.text = name
            }
            
            if let photo = person.valueForKey("imagePerfil") as? PFFile{
                
                //println("aqui:\(photo)")
                photo.getDataInBackgroundWithBlock({ (data, error) -> Void in
                    
                    if error == nil{
                        
                        let image = UIImage(data: data!)
                        cell.teacherImage.image = image
                    }
                    
                })
                
            }
            
            cellReturn = cell
            
            break
            
        case 1:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("teacherPhone", forIndexPath: indexPath) as! TecherPhoneCell
            
            if let phone = person.valueForKey("phone") as? String{
                
                cell.teacherPhone.userInteractionEnabled = true
                cell.teacherPhone.editable = false
                cell.teacherPhone.showsVerticalScrollIndicator = true
                cell.teacherPhone.scrollEnabled = true
                cell.teacherPhone.text = phone
            }
            
            cellReturn = cell
            
            break
            
        case 2:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("teacherEmail", forIndexPath: indexPath) as! TeacherEmailCell
            
            if let email = person.valueForKey("email") as? String{
                
                cell.teacherEmail.userInteractionEnabled = true
                cell.teacherEmail.editable = false
                cell.teacherEmail.showsVerticalScrollIndicator = true
                cell.teacherEmail.scrollEnabled = true
                cell.teacherEmail.text = email
            }
            
            cellReturn = cell
            
            break
            
        case 3:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("teacherDescription", forIndexPath: indexPath) as! TeacherDescriptionCell
            
            if let description = person.valueForKey("curriculum") as? String{
                
                //cell.teacherDescription.tag = indexPath.row
                cell.teacherDescription.userInteractionEnabled = true
                cell.teacherDescription.editable = false
                cell.teacherDescription.showsVerticalScrollIndicator = true
                cell.teacherDescription.scrollEnabled = true
                cell.teacherDescription.text = description
            }
            
            cellReturn = cell
            
            break
            
        case 4:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("addTeacherAd", forIndexPath: indexPath) as! AddTeacherAd
            
            //cell.AddTeacherAd.tag = indexPath.row
            cell.AddTeacherAd.addTarget(self, action: "addAdAction:", forControlEvents: .TouchUpInside)
            
            cell.seeTableAds.addTarget(self, action: "seeListAds:", forControlEvents: .TouchUpInside)
            
            cellReturn = cell
            
            break
            
        default:
            
            break
        }
        
        return cellReturn!
    }
    
    @IBAction func addAdAction(sender: UIButton) {
        
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let PerfilVC = storyboardMain.instantiateViewControllerWithIdentifier("AddAnnoucement") as? UIViewController
        self.navigationController?.pushViewController(PerfilVC!, animated: true)
        
    }
    
    @IBAction func seeListAds(sender: UIButton) {
        
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let PerfilVC = storyboardMain.instantiateViewControllerWithIdentifier("ShowListAds") as? UIViewController
        self.navigationController?.pushViewController(PerfilVC!, animated: true)
    }
    
    func actionLogout() {
        PFUser.logOut()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func actionCancel() {
        
        let newBarButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("actionLogout"))
        self.navigationItem.setLeftBarButtonItem(newBarButton, animated: true)
        
        self.navigationItem.rightBarButtonItem?.title = "Edit"
        
        var pathName = NSIndexPath(forRow: 0, inSection: 0)
        tableView.cellForRowAtIndexPath(pathName)
        var cellName = tableView.cellForRowAtIndexPath(pathName) as! TeacherCell
        cellName.teacherName.editable = false
        
        cellName.teacherImage.userInteractionEnabled = false
        
        var pathPhone = NSIndexPath(forRow: 0, inSection: 1)
        tableView.cellForRowAtIndexPath(pathPhone)
        var cellPhone = tableView.cellForRowAtIndexPath(pathPhone) as! TecherPhoneCell
        cellPhone.teacherPhone.editable = false
        
        var pathEmail = NSIndexPath(forRow: 0, inSection: 2)
        tableView.cellForRowAtIndexPath(pathEmail)
        var cellEmail = tableView.cellForRowAtIndexPath(pathEmail) as! TeacherEmailCell
        cellEmail.teacherEmail.editable = false
        
        var pathDescription = NSIndexPath(forRow: 0, inSection: 3)
        tableView.cellForRowAtIndexPath(pathDescription)
        var cellDescription = tableView.cellForRowAtIndexPath(pathDescription) as! TeacherDescriptionCell
        cellDescription.teacherDescription.editable = false
    }
    
    func actionImage(gesture: UITapGestureRecognizer) {
        
        let alertController = UIAlertController(title: "Set profile picture", message: "Choose", preferredStyle: UIAlertControllerStyle.ActionSheet)
        alertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
            
            //camera
            
            self.picker.allowsEditing = false
            self.picker.sourceType = .Camera
            self.presentViewController(self.picker, animated: true, completion: nil)
            
        }))
        alertController.addAction(UIAlertAction(title: "Galery", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
            
            //galery
            
            self.picker.allowsEditing = false
            self.picker.sourceType = .PhotoLibrary
            self.presentViewController(self.picker, animated: true, completion: nil)
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - UIImagePicker
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let choosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let imageData = UIImagePNGRepresentation(choosenImage)
        let imageSizeLength = imageData.length
        
        //Size limit for PFFILE in Parse 10485760 bytes
        if imageSizeLength <= 10485760 {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            let cellProfilePicture = tableView.cellForRowAtIndexPath(indexPath) as? TeacherCell
            
            cellProfilePicture?.teacherImage.contentMode = .ScaleAspectFit
            
            cellProfilePicture?.teacherImage.image = choosenImage
            
            //tableView.reloadData()
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            let alert = UIAlertController(title: "Image error", message: "Your image profile is very larger", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
