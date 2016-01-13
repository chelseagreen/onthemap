//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/3/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var annotations = [MKPointAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        loadMap()
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    //Links to student URL in Safari browser 
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let link = NSURLRequest(URL: NSURL(string: annotationView.annotation!.subtitle!!)!)
        UIApplication.sharedApplication().openURL(link.URL!)
    }
    
    func loadMap(success: Bool = true) {
        for StudentInfo in Users.sharedInstance().studentInfos {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: StudentInfo.latitude, longitude: StudentInfo.longitude)
            annotation.title = StudentInfo.fullName()
            annotation.subtitle = StudentInfo.linkUrl
            annotations.append(annotation); if success {
                    mapView.addAnnotations(annotations)
                } else {
                    displayMessageBox("Unable to load")
                }
        }
    }
    
    // MARK: Button Actions
    @IBAction func logout(sender: UIBarButtonItem) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func newPin(sender: UIBarButtonItem) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InfoPostViewController") as! InfoPostViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func refresh(sender: UIBarButtonItem) {
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations(annotationsToRemove)
        loadMap()
    }
    
    func displayMessageBox(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

    
    
    
    
    
    

