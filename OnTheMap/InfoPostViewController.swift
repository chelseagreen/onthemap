//
//  InfoPostViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/3/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit
import MapKit

class InfoPostViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var findOnMapButton: UIButton!
    @IBOutlet weak var submitPinButton: UIButton!
    @IBOutlet weak var studyLabel: UILabel!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var locationView: MKMapView!
    @IBOutlet weak var linkTextField: UITextField!
    
    var location: MKPlacemark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    
        locationTextField.delegate = self
        linkTextField.delegate = self
        
        view.backgroundColor = UIColor.orangeColor()
        
        findOnMapButton.layer.cornerRadius = 7
        submitPinButton.layer.cornerRadius = 7
        
        submitPinButton.hidden = true
        linkTextField.hidden = true
        locationView.hidden = true
    }
    
    //MARK: Keyboard functions
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func findOnMap(sender: AnyObject) {
        let address = locationTextField.text!
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                if let _ = error {
                    self.displayMessageBox("Unable to Locate")
                } else {
                    if let placemark = placemarks?[0] as? CLPlacemark? {
                        self.locationView.addAnnotation(MKPlacemark(placemark: placemark!))
                        
                        self.location = MKPlacemark(placemark: placemark!)
                        let span = MKCoordinateSpanMake(2, 2)
                        let region = MKCoordinateRegion(center: self.location.coordinate, span: span)
                        self.locationView.setRegion(region, animated: true)
                        
                        self.findOnMapButton.hidden = true
                        self.studyLabel.hidden = true
                        self.locationTextField.hidden = true
                        self.submitPinButton.hidden = false
                        self.linkTextField.hidden = false
                        self.locationView.hidden = false
                    }
                }
            })
        }

    @IBAction func submitNewPin(sender: UIButton) {
        let coord = location!.coordinate
        
        guard linkTextField.text != "" else {
            displayMessageBox("Please enter a link.")
            return
        }
        UserModel.sharedInstance().addNewPin(locationTextField.text!, mediaURL: linkTextField.text!, latitude: coord.latitude, longitude: coord.longitude) { (success, errorString) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
            if (success) {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.displayMessageBox("Error")
            }
        })
        }
    }

    func displayMessageBox(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}















    






