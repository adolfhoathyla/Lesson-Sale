//
//  ConfirmRegisterViewController.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 21/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class ConfirmRegisterViewController: UIViewController {

    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var myTextView: UITextView!
    
    @IBOutlet var buttonYes: UIButton!
    @IBOutlet var buttonNo: UIButton!
    
    var image = UIImage(named: "profileDefault")
    var name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageProfile.image = self.image
        myTextView.text = "Dear \(self.name), your register was done successfully"

        imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
        imageProfile.layer.masksToBounds = true
        
        buttonYes.layer.cornerRadius = 8.0
        buttonYes.clipsToBounds = true
        
        buttonNo.layer.cornerRadius = 8.0
        buttonNo.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func actionClose(sender: UIButton) {
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let PerfilVC = storyboardMain.instantiateViewControllerWithIdentifier("ProfileTeacherViewController") as? UIViewController
        
//        let navigation = UINavigationController(rootViewController: self)
//        navigation.pushViewController(PerfilVC!, animated: true)
        
//        self.navigationController?.pushViewController(PerfilVC!, animated: true)
//        self.dismissViewControllerAnimated(true, completion: nil)
        //self.presentViewController(PerfilVC!, animated: true, completion: nil)
    }
    
    @IBAction func actionNewAd(sender: UIButton) {
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let adVC = storyboardMain.instantiateViewControllerWithIdentifier("AddAnnoucement") as? UIViewController
        self.navigationController?.pushViewController(adVC!, animated: true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
