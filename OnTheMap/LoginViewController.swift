//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/3/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        
        view.backgroundColor = UIColor.blackColor()
        
        LoginButton.backgroundColor = UIColor.whiteColor()
        SignUpButton.backgroundColor = UIColor.blackColor()
    }

    //MARK: Actions
    @IBAction func loginButtonPressed(sender: UIButton) {
        // Make sure email and password are not empty.
        guard (!EmailTextField.text!.isEmpty && !PasswordTextField.text!.isEmpty) else {
            let alert = UIAlertController(title: "Error", message: "Email and/or password field is empty.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            return
            
        }
        
        UserModel.sharedInstance().login(EmailTextField.text!, password: PasswordTextField.text!) { (success, errorString) -> Void in
            guard success else {
                dispatch_async(dispatch_get_main_queue(), {
                    let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                })
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapTabBarController") as! UITabBarController
                self.presentViewController(controller, animated: true, completion: nil)

            })
            
        }
    }
    
    @IBAction func SignUpLink(sender: UIButton) {
        if let url = NSURL(string: "http://www.udacity.com") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    

// Move from email field to password field, and dismiss keyboard upon entering password
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == EmailTextField {
            PasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}


















