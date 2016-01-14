//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/4/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit

class TableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
      
    }
    
    //MARK: tableViewDelegate Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Users.sharedInstance().studentInfos.count
    }
    
    //Displays student data in each cell 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PinnedCell") as! PinnedCell

        let studentInfo = Users.sharedInstance().studentInfos[indexPath.row]
        
        cell.nameLabel.text = studentInfo.fullName()
        cell.locationLabel.text = studentInfo.linkUrl
        return cell
    }
    
    //Links to student url in Safari
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let studentInfo = Users.sharedInstance().studentInfos[indexPath.row]
        UIApplication.sharedApplication().openURL(NSURL(string: studentInfo.linkUrl)!)
    }
    
    @IBAction func refreshLocationData(sender: UIBarButtonItem) {
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: self.refreshLocations, object: self))
        UserModel.sharedInstance().getStudentLocations(Users.sharedInstance().accountKey!, completionHandler: { (success, errorString) -> Void in
            if (success) {
                UserModel.sharedInstance().parseStudentInfo({ (success, errorString) -> Void in
                    (success: success, errorString: errorString)
                })
            } else {
                (success: false, errorString: "Failure to connect.")
            }
        })
        
        tableView.reloadData()
        
    }
    
}












