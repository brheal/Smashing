//
//  GameScene.swift
//  SmashSmash
//
//  Created by Bryan Rhea on 4/25/16.
//  Copyright (c) 2016 Bryan Rhea. All rights reserved.
//

import SpriteKit
protocol GameSceneDelegate:class {
    func gameHasFinished(withFinalScore score:Int, scene:GameScene)
}
class GameScene: SKScene {
    let backgroundMusic = SKAudioNode(fileNamed: "bieberMusicCut.m4a")


    var target = SKSpriteNode(imageNamed: "bieberFace")
    var score = 0
    var seconds = 30
    let limitTime = 30
    var labelClock = SKLabelNode()
    var labelScore = SKLabelNode()
    var gsDelegate:GameSceneDelegate?
    override func didMoveToView(view: SKView) {
        self.scaleMode = SKSceneScaleMode.ResizeFill
        // 2
        backgroundColor = SKColor.whiteColor()
        // 3
        target.position = CGPoint(x: size.width * 0.1, y: size.height * 0.5)
        // 4
        addChild(target)
        
        labelClock.position = CGPoint(x: size.width / 2, y: size.height * 0.9 )
        labelClock.fontColor = UIColor.blueColor()
        labelClock.fontSize = 50
        addChild(labelClock)
        
        labelScore.position = CGPoint(x: size.width * 0.1, y: size.height * 0.9 )
        labelScore.fontColor = UIColor.greenColor()
        labelScore.fontSize = 80
        
        addChild(labelScore)
        
        target.name = "target"
        target.userInteractionEnabled = false
        
        addChild(backgroundMusic);

        startGame()
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func moveTarget() {
        
        // Determine where to spawn the target along the Y axis
        let actualY = random(min: target.size.height/2, max: size.height - target.size.height/2)
        
        // Determine where to spawn the target along the X axis
        let actualX = random(min: target.size.width/2, max: size.width - target.size.width/2)
        
        //set the position
        target.position = CGPoint(x: actualX, y: actualY)
        
    }
    
    override func update(currentTime: NSTimeInterval) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first!
        let location = touch.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        if node.name == "target" {
            score += 1
            labelScore.text = "\(score)"
            moveTarget()
        }
    }
    
    func startGame() {
        score = 0
        labelClock.text = "\(seconds)"
        labelScore.text = "0"
        labelClock.runAction(SKAction.repeatAction(SKAction.sequence([SKAction.waitForDuration(1), SKAction.runBlock({ self.timer()})]), count: limitTime)) {
                // This happens when the time expires 
            self.gameOver()
        }
        
        
        
    }
    
    
    func timer() {
        seconds -= 1
        labelClock.text = String(seconds)
    }
    
    func gameOver() {
        //stop music
        backgroundMusic.runAction(SKAction.stop())
        
        labelClock.removeAllActions()
        gsDelegate?.gameHasFinished(withFinalScore: score, scene: self)
    }
    
        
}
