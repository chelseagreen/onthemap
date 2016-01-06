//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Chelsea Green on 1/4/16.
//  Copyright © 2016 Chelsea Green. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: tableViewDelegate Methods

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserModel.sharedInstance().studentInfos.count
    }
    
    //Displays student data in each cell 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PinnedCell") as! PinnedCell
        
        let studentInfo = UserModel.sharedInstance().studentInfos[indexPath.row]
        
        cell.nameLabel.text = studentInfo.fullName()
        cell.locationLabel.text = studentInfo.linkUrl
        return cell
    }
    
    //Links to student url in Safari
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let studentInfo = UserModel.sharedInstance().studentInfos[indexPath.row]
        UIApplication.sharedApplication().openURL(NSURL(string: studentInfo.linkUrl)!)
    }
    
    
    // MARK: Actions
    @IBAction func logout() {
        UserModel.sharedInstance().logout()
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    
    @IBAction func newPin() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("InfoPostViewController") as! InfoPostViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func refresh() {
        tableView.reloadData()
        
    }
    
}























