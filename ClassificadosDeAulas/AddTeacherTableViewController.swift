//
//  AddTeacherTableViewController.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 17/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class AddTeacherTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let inputImage = ["Image profile"]
    let inputsPersonal = ["Name", "E-mail", "Phone"]
    let inputsAccount = ["Username", "Password", "Confirm password"]
    let inputCurriculum = ["Curriculum"]
    
    let picker = UIImagePickerController()
    
    var inputPhotoValendo: UIImage?
    
    var inputPersonalName = [String: String]()
    var inputPersonalEmail = [String: String]()
    var inputPersonalPhone = [String: String]()
    
    var inputCurriculumValendo: String?
    
    var inputAccountUsername = [String: String]()
    var inputAccountPassword = [String: String]()
    var inputAccountConfirmPassword = [String: String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismiss = UITapGestureRecognizer(target: self, action: Selector("actionDismissKeyboard"))
        view.addGestureRecognizer(dismiss)

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("actionDone"))
        
        self.tableView.tableFooterView = UIView()
        
        picker.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func actionDismissKeyboard() {
        view.endEditing(true)
    }
    
    func actionDone() {
        
        tableView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
        
        //name
        let cellName = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as? InputTeacherTableViewCell
        cellName?.input.resignFirstResponder()
        let textName = cellName?.input.text
        
        //email
        let cellEmail = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as? InputTeacherTableViewCell
        cellEmail?.input.resignFirstResponder()
        let textEmail = cellEmail?.input.text
        
        //phone
        let cellPhone = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1)) as? InputTeacherTableViewCell
        cellPhone?.input.resignFirstResponder()
        let textPhone = cellPhone?.input.text
        
        //Curriculum
        let cellCurriculum = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as? CurriculumTableViewCell
        cellCurriculum?.curriculumTextView.resignFirstResponder()
        let textCurriculum = cellCurriculum?.curriculumTextView.text
        
        //username
        let cellUsername = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as? InputTeacherTableViewCell
        cellUsername?.input.resignFirstResponder()
        let textUsername = cellUsername?.input.text
        
        //password
        let cellPassword = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 3)) as? InputTeacherTableViewCell
        cellPassword?.input.resignFirstResponder()
        let textPassword = cellPassword?.input.text
        
        //confirm password
        let cellConfirmPassword = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 3)) as? InputTeacherTableViewCell
        cellConfirmPassword?.input.resignFirstResponder()
        let textConfirmPassword = cellConfirmPassword?.input.text
        
        var message = ""
        var title = ""
        
        if textName == "" || textPhone == "" || textCurriculum == "" || textUsername == "" || textPassword == "" || textConfirmPassword == "" {
            
            title = "Fields Required"
            message = "Please, fill the required fields"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else if textPassword != textConfirmPassword {
            
            cellPassword?.input.text = ""
            cellConfirmPassword?.input.text = ""
            
            title = "Password error"
            message = "Password and confirm password must be equal"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
        
            let blockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            blockView.backgroundColor = UIColor.blackColor()
            blockView.alpha = 0.5
            
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
            
            spinner.center = view.center
            
            spinner.startAnimating()
            
            blockView.addSubview(spinner)
            
            self.view.addSubview(blockView)
            
            
            var name, phone, curriculum, username, password, confirmPassword: String!
            var email: String?
            
            if inputPersonalName.isEmpty {
                name = textName
            } else {
                name = inputPersonalName["name"]
            }
            
            if inputPersonalPhone.isEmpty {
                phone = textPhone
            } else {
                phone = inputPersonalPhone["phone"]
            }
            
            if inputAccountUsername.isEmpty {
                username = textUsername
            } else {
                username = inputAccountUsername["username"]
            }
            
            if inputAccountPassword.isEmpty {
                password = textPassword
            } else {
                password = inputAccountPassword["password"]
            }
            
            if inputAccountConfirmPassword.isEmpty {
                confirmPassword = textConfirmPassword
            } else {
                confirmPassword = inputAccountConfirmPassword["confirmPassword"]
            }
            
            if inputCurriculumValendo == "" {
                curriculum = textCurriculum
            } else {
                curriculum = inputCurriculumValendo
            }
            
            email = inputPersonalEmail["email"]
            
            if let username = username, password = password, name = name, phone = phone, curroculum = curriculum, imagePerfil = inputPhotoValendo {
                
                ParseHelper.addTeacher(username, password: password, name: name, email: email, phone: phone, curriculum: curriculum, imagePerfil: inputPhotoValendo!) { (teacher, error) -> () in
                    
                    if teacher != nil {
                        
                        let name = teacher?.objectForKey("name") as? String
                        
                        println("Professor \(name) cadastrado com sucesso")
                        
                        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
                        let profileVC = storyboardMain.instantiateViewControllerWithIdentifier("ProfileTeacherViewController") as? UIViewController
                        
                        //confirmRegisterVC?.name = name!
                        //confirmRegisterVC?.image = self.inputPhotoValendo
                        
                        spinner.stopAnimating()
                        blockView.removeFromSuperview()
                        
                        self.navigationController?.pushViewController(profileVC!, animated: true)
                        
                    } else {
                        
                        if let error = error {
                            
                            cellUsername?.input.text = ""
                            cellEmail?.input.text = ""
                            
                            spinner.stopAnimating()
                            blockView.removeFromSuperview()
                            
                            let errorString = error.userInfo?["error"] as? String
                            
                            let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                        }
                        
                        
                    }
                    
                }
                
            } else {
                
                spinner.stopAnimating()
                blockView.removeFromSuperview()
                
                title = "Fields Required"
                message = "Please, fill the required fields"
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)

            }
            
        

            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        var number = 0
        
        if section == 0 {
            number = self.inputImage.count
        } else if section == 1 {
            number = self.inputsPersonal.count
        } else if section == 2 {
            number = self.inputCurriculum.count
        } else if section == 3 {
            number = self.inputsAccount.count
        }
        
        return number
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title = ""
        
        switch section {
        case 0:
            title = "Image profile"
            break
        case 1:
            title = "Personal"
            break
        case 2:
            title = "Curriculum"
            break
        case 3:
            title = "Account"
            break
        default:
            break
        }
        return title
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200.0
        }
        if indexPath.section == 2 {
            return 200.0
        }
        return 50.0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderTableViewCell
        
        switch section {
        case 0:
            headerCell.labelHeader.text = "Image Profile"
            break
        case 1:
            headerCell.labelHeader.text = "Personal Information"
            break
        case 2:
            headerCell.labelHeader.text = "Curriculum"
            break
        case 3:
            headerCell.labelHeader.text = "Account"
            break
        default:
            break
        }

        return headerCell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellReturn: UITableViewCell?
        
        switch indexPath.section {
        
        case 0:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoTableViewCell
            let gesture = UITapGestureRecognizer(target: self, action: Selector("actionImage:"))
            gesture.numberOfTapsRequired = 1
            cell.imagePerfil.addGestureRecognizer(gesture)
            cell.userInteractionEnabled = true
            
            cellReturn = cell
            
            break
        case 1:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("inputCell", forIndexPath: indexPath) as! InputTeacherTableViewCell
            
            if indexPath.row == 0 {
                cell.input.autocapitalizationType = UITextAutocapitalizationType.Words
                cell.input.autocorrectionType = UITextAutocorrectionType.No
            }
            
            if indexPath.row == 1 {
                cell.input.keyboardType = UIKeyboardType.EmailAddress
                cell.requiredField.hidden = true
                cell.input.autocapitalizationType = UITextAutocapitalizationType.None
                cell.input.autocorrectionType = UITextAutocorrectionType.No
            }
            
            if indexPath.row == 2 {
                cell.input.keyboardType = UIKeyboardType.NumberPad
                
            }
            
            cell.input.placeholder = inputsPersonal[indexPath.row]
            
            cellReturn = cell
            
            break
        case 2:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("curriculumCell", forIndexPath: indexPath) as! CurriculumTableViewCell
            cell.curriculumTextView.text = "Job description"
            cell.curriculumTextView.textColor = UIColor.grayColor()
            
            cellReturn = cell
            
            break
        case 3:
            
            var cell = tableView.dequeueReusableCellWithIdentifier("inputCell", forIndexPath: indexPath) as! InputTeacherTableViewCell
            
            if indexPath.row == 0 {
                cell.input.autocapitalizationType = UITextAutocapitalizationType.None
                cell.input.autocorrectionType = UITextAutocorrectionType.No
            }
            
            if indexPath.row == 1 || indexPath.row == 2 {
                cell.input.secureTextEntry = true
            }
            cell.input.placeholder = inputsAccount[indexPath.row]
            
            cellReturn = cell
            
            break
        default:
            break
        }
        
        return cellReturn!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {

        //Image
        if inputPhotoValendo == nil {
            let cellPhoto = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? PhotoTableViewCell
            inputPhotoValendo = cellPhoto?.imagePerfil.image
        }
        
        //Personal
        let cellName = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as? InputTeacherTableViewCell
        if let text = cellName?.input.text {
            if text != "" {
                inputPersonalName = ["name": text]
            }
        }
        
        let cellEmail = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as? InputTeacherTableViewCell
        if let text = cellEmail?.input.text {
            if text != "" {
                inputPersonalEmail = ["email": text]
            }
        }
        
        let cellPhone = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1)) as? InputTeacherTableViewCell
        if let text = cellPhone?.input.text {
            if text != "" {
                inputPersonalPhone = ["phone": text]
            }
        }
        
        //Curriculum
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 2)) as? CurriculumTableViewCell
        inputCurriculumValendo = cell?.curriculumTextView.text
        
        //Account
        let cellUsername = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 3)) as? InputTeacherTableViewCell
        if let text = cellUsername?.input.text {
            if text != "" {
                inputAccountUsername = ["username": text]
            }
        }
        
        let cellPassword = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 3)) as? InputTeacherTableViewCell
        if let text = cellPassword?.input.text {
            if text != "" {
                inputAccountPassword = ["password": text]
            }
        }
        
        let cellConfirmPassword = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 3)) as? InputTeacherTableViewCell
        if let text = cellConfirmPassword?.input.text {
            if text != "" {
                inputAccountConfirmPassword = ["confirmPassword": text]
            }
        }

        
        println("Personal: \(inputPersonalName) and \(inputPersonalEmail) and \(inputPersonalPhone)")
        println("Account: \(inputAccountUsername) and \(inputAccountPassword) and \(inputAccountConfirmPassword)")
        println("Curriculum: \(inputCurriculumValendo)")
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UIImagePicker
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let choosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        let imageData = UIImagePNGRepresentation(choosenImage)
        let imageSizeLength = imageData.length
        
        //Size limit for PFFILE in Parse 10485760 bytes
        if imageSizeLength <= 10485760 {
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            let cellProfilePicture = tableView.cellForRowAtIndexPath(indexPath) as? PhotoTableViewCell
            
            cellProfilePicture?.imagePerfil.contentMode = .ScaleAspectFit
            
            cellProfilePicture?.imagePerfil.image = choosenImage
            
            tableView.reloadData()
            
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
