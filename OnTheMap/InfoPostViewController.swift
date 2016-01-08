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
    
    @IBOutlet weak var FindOnMapButton: UIButton!
    @IBOutlet weak var SubmitPinButton: UIButton!
    @IBOutlet weak var StudyLabel: UILabel!
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var LocationView: MKMapView!
    @IBOutlet weak var LinkTextField: UITextField!
    
    var location: MKPlacemark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    
        LocationTextField.delegate = self
        LinkTextField.delegate = self
        
        view.backgroundColor = UIColor.greenColor()
        
        FindOnMapButton.layer.cornerRadius = 7
        SubmitPinButton.layer.cornerRadius = 7 
        
        SubmitPinButton.hidden = true
        LinkTextField.hidden = true
        LocationView.hidden = true
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
        
        let address = LocationTextField.text!
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                if let address = error {
                    let alert = UIAlertController(title: "", message: "Unable to Locate", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    if let placemark = placemarks?[0] as? CLPlacemark? {
                        self.LocationView.addAnnotation(MKPlacemark(placemark: placemark!))
                        
                        self.location = MKPlacemark(placemark: placemark!)
                        let span = MKCoordinateSpanMake(2, 2)
                        let region = MKCoordinateRegion(center: self.location.coordinate, span: span)
                        self.LocationView.setRegion(region, animated: true)
                        
                        self.FindOnMapButton.hidden = true
                        self.StudyLabel.hidden = true
                        self.LocationTextField.hidden = true
                        self.SubmitPinButton.hidden = false
                        self.LinkTextField.hidden = false
                        self.LocationView.hidden = false
                    }
                }
                
            })
        
        }

    @IBAction func submitNewPin(sender: UIButton) {
        let coord = location!.coordinate
        
        guard LinkTextField.text != "" else {
            let alert = UIAlertController(title: "Error", message: "Please enter a link", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        UserModel.sharedInstance().addNewPin(LocationTextField.text!, mediaURL: LinkTextField.text!, latitude: coord.latitude, longitude: coord.longitude) { (success, errorString) -> Void in
            dispatch_async(dispatch_get_main_queue(), {
            if (success) {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: errorString!, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
        }
    }

}
























    






