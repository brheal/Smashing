//
//  LeaderboardTableViewController.swift
//  Smash Smash
//
//  Created by Timothy Barrett on 4/27/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class LeaderboardTableViewController: UITableViewController {
    private var leaders:[Leader] = [Leader]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.registerNib(UINib(nibName: "LeaderCell", bundle: nil), forCellReuseIdentifier: LeaderCellTableViewCell.reuseID)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80.0
        self.refreshControl?.addTarget(self, action: #selector(reloadData), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leaders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LeaderCellTableViewCell.reuseID, forIndexPath: indexPath) as! LeaderCellTableViewCell
        let leader = leaders[indexPath.row]
        cell.playerNameLabel.text = leader.leaderName
        if leader.leaderScore != nil {
            cell.playerScoreLabel.text = "\(leader.leaderScore!)"
        }
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func reloadData() {
        // reload data from parse
        GameStore.shared.getTopScores { (leaders, error) in
            dispatch_async(dispatch_get_main_queue(), {
                print(leaders.count)
                self.leaders = leaders
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            })
        }
    }

}
