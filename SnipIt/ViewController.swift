//
//  ViewController.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/19/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userIdText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.userIdText.delegate = self
        self.passwordText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("UID") != nil {
            self.performSegueWithIdentifier("homePage", sender: nil)
        }
    }
    
    @IBAction func onScreenTap(sender: UITapGestureRecognizer) {
        self.userIdText.resignFirstResponder()
        self.passwordText.resignFirstResponder()
    }
    
    @IBAction func fbButtonPressed(sender: UIButton!) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError == nil {
                
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("Successfully logged in with facebook. \(accessToken)")
                
                DataService.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: {error, authData in
                    if error == nil {
                        print("Logged In! \(authData)")
                        
                        let user = ["provider" :authData.provider!, "blah": "Test"]
                        DataService.ds.createUser(authData.uid, user: user)
                        
                        
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "UID")
                        self.performSegueWithIdentifier("homePage", sender: nil)
                    } else {
                        print("Login failed. \(error)")
                    }
                })
                
            } else {
                print("Login failed. Error\(facebookError)")
            }
        }
    }

    @IBAction func loginButtonPressed(sender: UIButton!) {
        if let userId = userIdText.text where userId != "", let pwd = passwordText.text where pwd != "" {
            DataService.ds.REF_BASE.authUser(userId, password: pwd, withCompletionBlock: {
                error, authData in
                
                if error != nil {
                    if error.code == -8 {
                       self.showErrorAlert("Account does not exist", msg: "Oops! Looks like you haven't created an account with us yet!")
                        
                    }
                    else {
                        self.showErrorAlert("Invalid UserID or Password", msg: "Oops! Looks like you've made a typo or forgotten your username/password!")
                    }
                } else {
                    print("Logged In!")
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "accountUID")
                    self.performSegueWithIdentifier("homePage", sender: nil)
                }
            })
        } else {
            showErrorAlert("User Email and Password Required", msg: "You must enter an e-mail ID and a password")
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}

