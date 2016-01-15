//
//  BaseViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/13/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit
import MapKit


class BaseViewController: UIViewController {
    
    @IBOutlet var logout: UIBarButtonItem!
    @IBOutlet var refresh: UIBarButtonItem!
    @IBOutlet var newPin: UIBarButtonItem!
    
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView (activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setRightBarButtonItems([newPin, refresh], animated: false)
        navigationItem.setLeftBarButtonItems([logout], animated: false)
        
        indicator.color = UIColor.orangeColor()
        indicator.frame = CGRectMake(0, 0, 10, 10)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubviewToFront(self.view)
    }
    
    // MARK: Button Actions
    @IBAction func newPin(sender: UIBarButtonItem) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InfoPostViewController") as! InfoPostViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }

    @IBAction func logout(sender: UIBarButtonItem) {
        UserModel.sharedInstance().deleteUserSession { (success, errorString) -> Void in
            if (success == true) {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                (success: false, errorString: "Failure to logout.")
            }
        }
    }
    
    func displayMessageBox(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}




















