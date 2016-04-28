//
//  ScoreReviewViewController.swift
//  Smash Smash
//
//  Created by Timothy Barrett on 4/27/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import UIKit

class ScoreReviewViewController: UIViewController {

    @IBOutlet weak var uploadView: UIVisualEffectView!
    @IBOutlet weak var finalScoreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        uploadView.alpha = 0.0
        finalScoreLabel.text = "\(Player.currentPlayer.finalScore)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadPressed(sender: AnyObject) {
        // upload final score to parse
        if Player.currentPlayer.playerName != nil {
            UIView.animateWithDuration(0.35, animations: { 
                self.uploadView.alpha = 1.0
            })
            GameStore.shared.uploadScore(withPlayerName: Player.currentPlayer.playerName!, withScore: Player.currentPlayer.finalScore, completion: { (success, err) in
                if err == nil && success {
                    // go to leaderboard
                    self.performSegueWithIdentifier("showLeaderboard", sender: nil)
                } else {
                    // show error
                    self.performSegueWithIdentifier("showLeaderboard", sender: nil)
                }
            })
        }
        
        // show leader board screen
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
