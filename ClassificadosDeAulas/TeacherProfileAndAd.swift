//
//  TeacherProfileAndAdTableViewController.swift
//  ClassificadosDeAulas
//
//  Created by Davi Freire on 29/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class TeacherProfileAndAd: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
	
	//var objectId: String! //recebera o objectId do anúncio para pesquisa na tabela do PARSE
    var objectId: String?
	var titleAd: String?
	var descriptionAd: String?
	var duration: String?
	var equipment: String?
	
	var objectIdTeacher: String?
	var nameTeacher: String?
	var curriculumTeacher: String?
	var emailTeacher: String?
	var phoneTeacher: String?
	var photoTeacher: PFFile?
	var imageTeacher: UIImage?
	//falta a imagem de perfil
	

	
	let picker = UIImagePickerController()

	override func viewDidAppear(animated: Bool) {
		self.tableView.reloadData()
		println("id teacher:\(objectIdTeacher)")
	}
	// MARK: - Initializa a class
	override func viewDidLoad() {
		super.viewDidLoad()
		
        println("teste do obID:\(objectId)")
		
		loadAdvertisement()
		println("name do prof\(self.nameTeacher)")
		


		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		picker.delegate = self
		
		//Looks for single or multiple taps.
		var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
		
		tableView.allowsSelection = false
		
		self.tableView.delegate = self
		
	}
	
	func loadAdvertisement() {
		
		var query = PFQuery(className: "Advertisement")
		
		//if let objId = objectId {
			query.getObjectInBackgroundWithId(objectId!, block: { (object, error) -> Void in
				if error == nil {
					//LOAD TEACHER
					if let teacher = object?["teacher"] as? PFObject, objectIdT = teacher.objectId {
						self.objectIdTeacher = objectIdT
						
						let query = PFUser.query()
						query!.getObjectInBackgroundWithId(self.objectIdTeacher!, block: { (teacher, error) -> Void in
							if error == nil {
								
								if let name = teacher?["name"] as? String, curriculum = teacher?["curriculum"] as? String, email = teacher?["email"] as? String, phone = teacher?["phone"] as? String, photo = teacher?["imagePerfil"] as? PFFile {
									
									self.nameTeacher = name
									self.curriculumTeacher = curriculum
									self.phoneTeacher = phone
									self.emailTeacher = email
									//									self.photoTeacher = photo
									photo.getDataInBackgroundWithBlock({ (data, error) -> Void in
										
										if error == nil{
											
											self.imageTeacher = UIImage(data: data!)
											
										}
										
									})
								}
							}
						})
						
					}

					
					if let titleQ = object!.valueForKey("title") as? String{
						self.titleAd = titleQ
						//println("titulo hehe\(self.titleAd)")
					}
					if let descriptionQ = object!["description"] as? String{
						self.descriptionAd = descriptionQ
						//println("desc \(self.descriptionAd)")
					}
					if let durationQ = object!.valueForKey("duration") as? String{
						self.duration = durationQ
						//println("duration hehe\(self.duration)")
					}
					if let equipmentQ = object!.valueForKey("equipment") as? String{
						self.equipment = equipmentQ
					}
					

					
				} else {
					println(error)
				}
			})
		
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
	
		
	// MARK: - Table view data source
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		
		return 5
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == 4{
			return 4
		}
		return 1
	}
	
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0{
			
			return "Teacher"
		}
		if section == 1{
			
			return "Personal Information"
		}
		if section == 4{
			
			return "Advertisement"
		}
		
		return nil
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		
		if indexPath.section == 0 {
			return 190.0
		}
		
		if indexPath.section == 3{
			return 120.0
		}
		return 50.0
	}
	
	override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		var headerCell = tableView.dequeueReusableCellWithIdentifier("teacherHeader") as? HeaderAndAd
		
		switch section {
		case 0:
			headerCell?.labelHeader.text = "Teacher"
			break
		case 1:
			headerCell?.labelHeader.text = "Personal Information"
			break
		case 4:
			headerCell?.labelHeader.text = "Advertisement"
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
			height = 25
			break
		default:
			break
		}
		
		return height!
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
		var cellReturn:UITableViewCell?

		switch indexPath.section{
		case 0:
			
			var cell = tableView.dequeueReusableCellWithIdentifier("teacherNameAndAd") as! TeacherNameAndAd!
			if cell == nil {
				cell = TeacherNameAndAd(style: UITableViewCellStyle.Default, reuseIdentifier: "teacherNameAndAd")
			}
			
		
				
				cell.teacherName.userInteractionEnabled = true
				cell.teacherName.text = self.nameTeacher
				cell.teacherImage.image = self.imageTeacher
			
			//if let photo = person.valueForKey("imagePerfil") as? PFFile{
				
				//println("aqui:\(photo)")
//				self.photoTeacher!.getDataInBackgroundWithBlock({ (data, error) -> Void in
//					
//					if error == nil{
//
//						let image = UIImage(data: data!)
//						cell.teacherImage.image = image
//					}
//					
//				})
			
			//}
			
			cellReturn = cell
			
			break
			
		case 1:
			
			var cell = tableView.dequeueReusableCellWithIdentifier("teacherPhoneAndAd") as! TeacherPhoneAndAd!
			if cell == nil {
				cell = TeacherPhoneAndAd(style: UITableViewCellStyle.Default, reuseIdentifier: "teacherPhoneAndAd")
			}

			

				
				cell.teacherPhone.userInteractionEnabled = true
//				cell.teacherPhone.editable = false
//				cell.teacherPhone.showsVerticalScrollIndicator = true
//				cell.teacherPhone.scrollEnabled = true
				cell.teacherPhone.text = self.phoneTeacher
			
			
			cellReturn = cell
			
			break
			
		case 2:
			
			var cell = tableView.dequeueReusableCellWithIdentifier("teacherEmailAndAd") as! TeacherEmailAndAd!
			if cell == nil {
				cell = TeacherEmailAndAd(style: UITableViewCellStyle.Default, reuseIdentifier: "teacherEmailAndAd")
			}
			
				
				cell.teacherEmail.userInteractionEnabled = true
				cell.teacherEmail.text = self.emailTeacher

			
			cellReturn = cell
			
			break
			
		case 3:
			
			var cell = tableView.dequeueReusableCellWithIdentifier("teacherDescriptionAndAd") as! TeacherDescriptionAndAd!
			if cell == nil {
				cell = TeacherDescriptionAndAd(style: UITableViewCellStyle.Default, reuseIdentifier: "teacherDescriptionAndAd")
			}
			
				//cell.teacherDescription.tag = indexPath.row
				cell.teacherDescription.userInteractionEnabled = true
				cell.teacherDescription.editable = false
				cell.teacherDescription.showsVerticalScrollIndicator = true
				cell.teacherDescription.scrollEnabled = true
				cell.teacherDescription.text = self.curriculumTeacher
			
			cellReturn = cell
			
			break
			
		case 4:
			//irá ser o anúncio aqui
//			var cell = tableView.dequeueReusableCellWithIdentifier("teacherAdvertisement") as! TeacherAdCell!
//			
			var cell = tableView.dequeueReusableCellWithIdentifier("adCell") as! AdCell!
			if cell == nil {
				cell = AdCell(style: UITableViewCellStyle.Default, reuseIdentifier: "adCell")
			}
			
			
			
			
			if indexPath.row == 0{
				
				cell.ad.text = "Title:"
				cell.dados.text = self.titleAd
			}
			
			if indexPath.row == 1 {
				cell.ad.text = "Description:"
				cell.dados.text = self.descriptionAd
			}
			
			if indexPath.row == 2 {
				cell.ad.text = "Duration:"
				cell.dados.text = self.duration
			}
			
			if indexPath.row == 3 {
				cell.ad.text = "Equipment:"
				cell.dados.text = self.equipment
			}
			
			cellReturn = cell
						
		default:
			
			break
		}
		
		return cellReturn!
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
			
			//cellProfilePicture?.teacherImage.contentMode = .ScaleAspectFit
			
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
