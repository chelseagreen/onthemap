//
//  Users.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/13/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import Foundation

class Users: NSObject {
    var accountKey: String?
    var userFirstName: String?
    var userLastName: String?
    var sessionId: String?
    var studentInfos: [StudentInfo]
    
    override init() {
        studentInfos = [StudentInfo]()
    }
    
    class func sharedInstance() -> Users {
        struct Singleton {
            static var sharedInstance = Users()
        }
        return Singleton.sharedInstance
    }
}
