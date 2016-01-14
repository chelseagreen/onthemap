//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/3/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController, MKMapViewDelegate {
    
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

    func refreshMapView() {
    }
    
    @IBAction func refreshLocationData(sender: UIBarButtonItem) {
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations(annotationsToRemove)
    
        UserModel.sharedInstance().getStudentLocations(Users.sharedInstance().accountKey!, completionHandler: { (success, errorString)  -> Void in
            if (success) {
                UserModel.sharedInstance().parseStudentInfo({ (success, errorString) -> Void in
                    (success: success, errorString: errorString)
                })
            } else {
                (success: false, errorString: "Failure to connect.")
            }
        })
        
        loadMap()
        
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
    
    func geoloadingStart() {
     //TODO: add geoloading start / finish notification
    }
}






    

