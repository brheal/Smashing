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
    private var originalBounds:CGRect?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        uploadView.alpha = 0.0
        finalScoreLabel.text = "\(Player.currentPlayer.finalScore)"
        originalBounds = CGRectMake(finalScoreLabel.frame.origin.x, finalScoreLabel.frame.origin.y, finalScoreLabel.bounds.width, finalScoreLabel.bounds.height)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        finalScoreLabel.frame.origin.x = self.view.frame.origin.x - 10
        UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 20.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.finalScoreLabel.frame.origin.x = self.view.bounds.width / 2 - (self.finalScoreLabel.bounds.width / 2)
            }) { (fin) in
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
                } else {
                    self.performSegueWithIdentifier("showLeaderboard", sender: nil)
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadPressed(sender: AnyObject) {
        // upload final score to parse

        
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
