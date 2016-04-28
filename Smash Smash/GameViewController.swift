//
//  GameViewController.swift
//  SmashSmash
//
//  Created by Bryan Rhea on 4/25/16.
//  Copyright (c) 2016 Bryan Rhea. All rights reserved.
//

import UIKit
import SpriteKit
class GameViewController: UIViewController {
    var scene:GameScene?
    override func viewDidLoad() {
        super.viewDidLoad()
        scene = GameScene(size: view.bounds.size)
        scene?.backgroundColor = UIColor.clearColor()
        let skView = view as! SKView
        scene?.gsDelegate = self
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene?.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

extension GameViewController : GameSceneDelegate {
    func gameHasFinished(withFinalScore score: Int, scene: GameScene) {
        Player.currentPlayer.updatePlayerScore(withNewScore: score)
        self.performSegueWithIdentifier("showFinalScore", sender: nil)
    }
}