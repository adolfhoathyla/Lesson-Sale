//
//  LoginViewController.swift
//  ClassificadosDeAulas
//
//  Created by Adolfho Athyla on 17/07/15.
//  Copyright (c) 2015 Adolfho Athyla. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var loginTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var buttonCreateAccount: UIButton!
    @IBOutlet var buttonGo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextfield.secureTextEntry = true
        
        loginTextfield.delegate = self
        passwordTextfield.delegate = self
        
        loginTextfield.becomeFirstResponder()
        
        buttonCreateAccount.layer.cornerRadius = 8.0
        buttonCreateAccount.clipsToBounds = true
        
        buttonGo.layer.cornerRadius = 8.0
        buttonGo.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        loginTextfield.text = ""
        passwordTextfield.text = ""
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

    
    @IBAction func actionCreateAccount(sender: UIButton) {
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let addTeacherVC = storyboardMain.instantiateViewControllerWithIdentifier("AddTeacherViewController") as? UIViewController
        self.navigationController?.pushViewController(addTeacherVC!, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let blockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        blockView.backgroundColor = UIColor.blackColor()
        blockView.alpha = 0.5
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        blockView.addSubview(spinner)
        
        self.view.addSubview(blockView)
        
        if loginTextfield.text != "" && passwordTextfield.text != "" {
            
            ParseHelper.loggingIn(loginTextfield.text, password: passwordTextfield.text) { (user, error) -> () in
                
                if user != nil {
                    println("Login success! \(user?.username)")
                    
                    let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
                    let PerfilVC = storyboardMain.instantiateViewControllerWithIdentifier("ProfileTeacherViewController") as? UIViewController
                    self.navigationController?.pushViewController(PerfilVC!, animated: true)
                    
                    spinner.stopAnimating()
                    blockView.removeFromSuperview()
                    
                } else {
                    println("Login error: \(error)")
                    
                    spinner.stopAnimating()
                    blockView.removeFromSuperview()
                    
                    let info = error!.userInfo?["error"] as? String
                    let alert = UIAlertController(title: "Login failed", message: info, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                
            }
            
        } else {
            
            spinner.stopAnimating()
            blockView.removeFromSuperview()
            
            let alert = UIAlertController(title: "Login failed", message: "Please, fill the required fields", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        return false
    }

    @IBAction func actionGo(sender: UIButton) {
        
        let blockView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        blockView.backgroundColor = UIColor.blackColor()
        blockView.alpha = 0.5
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        spinner.center = view.center
        
        spinner.startAnimating()
        
        blockView.addSubview(spinner)
        
        self.view.addSubview(blockView)
        
        if loginTextfield.text != "" && passwordTextfield.text != "" {
            
            ParseHelper.loggingIn(loginTextfield.text, password: passwordTextfield.text) { (user, error) -> () in
                
                if user != nil {
                    println("Login success! \(user?.username)")
                    
                    let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
                    let PerfilVC = storyboardMain.instantiateViewControllerWithIdentifier("ProfileTeacherViewController") as? UIViewController
                    self.navigationController?.pushViewController(PerfilVC!, animated: true)
                    
                    spinner.stopAnimating()
                    blockView.removeFromSuperview()
                    
                } else {
                    println("Login error: \(error)")
                    
                    spinner.stopAnimating()
                    blockView.removeFromSuperview()
                    
                    let info = error!.userInfo?["error"] as? String
                    let alert = UIAlertController(title: "Login failed", message: info, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                
                
            }
            
        } else {
            
            spinner.stopAnimating()
            blockView.removeFromSuperview()
            
            let alert = UIAlertController(title: "Login failed", message: "Please, fill the required fields", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }

}
