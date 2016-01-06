//
//  InfoPostViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/3/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit
import MapKit

class InfoPostViewController: UIViewController {
    
    @IBOutlet weak var FindOnMapButton: UIButton!
    @IBOutlet weak var SubmitPinButton: UIButton!
    @IBOutlet weak var StudyLabel: UILabel!
    @IBOutlet weak var LocationTextField: UITextField!
    @IBOutlet weak var LocationView: MKMapView!
    @IBOutlet weak var LinkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orangeColor()
        
        SubmitPinButton.hidden = true
        LinkTextField.hidden = true
        LocationView.hidden = true
    }
    
    //MARK: Actions
    @IBAction func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func findOnMap(sender: UIButton) {
        
        let address = LocationTextField.text!
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark? {
                self.LocationView.addAnnotation(MKPlacemark(placemark: placemark!))
           
    
                self.FindOnMapButton.hidden = true
                self.StudyLabel.hidden = true
                self.LocationTextField.hidden = true
                self.SubmitPinButton.hidden = false
                self.LinkTextField.hidden = false
                self.LocationView.hidden = false
            }
        })
    }

}






