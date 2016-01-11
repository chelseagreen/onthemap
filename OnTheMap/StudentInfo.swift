//
//  StudentInfo.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/9/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import Foundation

struct StudentInfo {
    var firstName: String
    var lastName: String
    var linkUrl: String
    var latitude: Double
    var longitude: Double
    
    init(dictionary: [String: AnyObject]) {
        firstName = dictionary["firstName"] as! String
        lastName = dictionary["lastName"] as! String
        linkUrl = dictionary["linkUrl"] as! String
        latitude = dictionary["latitude"] as! Double
        longitude = dictionary["longitude"] as! Double
    }
    
    func fullName() -> String {
        return firstName + " " + lastName
    }
}

