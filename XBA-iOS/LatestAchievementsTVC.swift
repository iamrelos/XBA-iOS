//
//  LatestAchievementsTableViewController.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/26/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit

class LatestAchievementsTVC: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    
    var latestAchievements = [LatestAchievements]()
    var comments: [Comment]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getLatestAchievements(1)
        
        self.tableview.estimatedRowHeight = 184.0
        self.tableview.rowHeight = UITableViewAutomaticDimension
        
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableview.tableFooterView = UIView(frame: CGRectZero)
        self.tableview.backgroundColor = UIColor.whiteColor()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.latestAchievements.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LatestAchievementsCellIdentifier", forIndexPath: indexPath) as! LatestAchievementsTVCCell

        // Remove seperator inset
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        // Prevent the cell from inheriting the Table View's margin settings
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        // Explictly set your cell's layout margins
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        let achievement = latestAchievements[indexPath.row]
        
        cell.configureCellWith(achievement)

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {

            if identifier == "CommentsIdentifier" {
                let commentsVC = segue.destinationViewController as? CommentsTVC
                
                if let index = self.tableview.indexPathForCell(sender as! UITableViewCell) {
                    commentsVC!.permalink = latestAchievements[index.row].commentsPermalink
                }
            }
        }
    }
    
    func getLatestAchievements(pageNumber: Int){
        RequestHandler.getLatestAchievements(1, completion: {(result) -> Void in
            self.latestAchievements = [LatestAchievements]()
            self.latestAchievements = result
            self.tableview.reloadData()
            self.refreshControl?.endRefreshing()
        })
    }

    func refresh(sender: AnyObject){
        self.getLatestAchievements(1)
    }
}
