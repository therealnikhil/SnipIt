//
//  CreateAccountViewController.swift
//  SnipIt
//
//  Created by Nikhil Nandkumar on 2/20/16.
//  Copyright © 2016 divnik. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var pwdText: UITextField!
    @IBOutlet weak var pwdConfirmText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func accountButtonPressed (sender: UIButton!) {
        if let userId = emailText.text where userId != "", let pwd = pwdText.text where pwd != "", let pwdConfirm = pwdConfirmText.text where pwdConfirm != "" {
            if pwd == pwdConfirm {
                DataService.ds.REF_BASE.authUser(userId, password: pwd, withCompletionBlock: {
                    error, authData in
                    
                    if error != nil {
                        if error.code == -8 {
                            DataService.ds.REF_BASE.createUser(userId, password: pwd, withValueCompletionBlock: {
                                error, result in
                                
                                DataService.ds.REF_BASE.authUser(userId, password: pwd, withCompletionBlock:{ err, authData in
                                    
                                    let user = ["provider" :authData.provider!, "blah": "emailTest"]
                                    DataService.ds.createUser(authData.uid, user: user)
                                    
                                })
                                
                                NSUserDefaults.standardUserDefaults().setValue(result ["UID"], forKey: "UID")
                                self.performSegueWithIdentifier("homePageFromCreate", sender: nil)
                            })
                        }
                    } else {
                        self.showErrorAlert("Account Already Exists", msg: "Oops! Looks like you should be on the Log In page!")
                    }
                })
            } else {
                self.showErrorAlert("Confirm Password Error", msg: "Oops! Looks like your passwords don't match!")
            }
        } else {
            showErrorAlert("Please Enter All Fields", msg: "Oops! Looks like you've left one or more required fields blank")
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
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
