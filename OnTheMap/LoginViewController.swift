//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/3/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        view.backgroundColor = UIColor.blackColor()
        
        
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.layer.cornerRadius = 5
        signUpButton.backgroundColor = UIColor.blackColor()
    }

    //MARK: Actions
    @IBAction func loginButtonPressed(sender: UIButton) {
        // Make sure email and password are not empty.
        guard (!emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty) else {
            displayMessageBox("Email and/or password field is empty.")
            return
        }
        
        UserModel.sharedInstance().postUserSession(emailTextField.text!, password: passwordTextField.text!) { (success, errorString) -> Void in
            guard success else {
                dispatch_async(dispatch_get_main_queue(), {
                    self.displayMessageBox(errorString!)
                })
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapTabBarController") as! UITabBarController
                self.presentViewController(controller, animated: true, completion: nil)
            })
            
        }
    }
    
    @IBAction func signUpLink(sender: UIButton) {
        if let url = NSURL(string: "http://www.udacity.com") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    //MARK: Keyboard Functions
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Move from email field to password field, and dismiss keyboard upon entering password
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func displayMessageBox(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}














