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
    
    func pickMusic() -> String {
        let musicPick = Int(arc4random_uniform(UInt32(3)))
        
        if musicPick == 1 {
            return "bieberMusicCut.m4a"
        } else if musicPick == 2 {
            return "bieberMusicCut2.m4a"
        } else {
            return "turnDown.m4a"
        }
    }

    
    
    var target = SKSpriteNode(imageNamed: "bieberFace")
    var inBonus = false
    var pointValue = 1
    var score = 0
    var seconds = 30
    let limitTime = 30
    let mileyBonusScore = 40
    var labelClock = SKLabelNode()
    var labelScore = SKLabelNode()
    var labelBonus = SKLabelNode()
    
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
        
        labelBonus.position = CGPoint(x: size.width * 0.8, y: size.height * 0.9 )
        labelBonus.fontColor = UIColor.magentaColor()
        labelBonus.fontSize = 60
        labelBonus.text = "Miley Bonus!"
        labelBonus.hidden = true
        addChild(labelBonus)
        
        
        target.name = "target"
        target.userInteractionEnabled = false
        
        runAction(SKAction.playSoundFileNamed(pickMusic(), waitForCompletion: false))
        
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
            runAction(SKAction.playSoundFileNamed("PrinceScream.m4a", waitForCompletion: false))
            score += pointValue
            moveTarget()
        } else {
            score -= 1
        }
        
        //check for bonus
        if !inBonus && (score > mileyBonusScore) {
            inBonus = true
            labelBonus.hidden = false
            target.texture = SKTexture(imageNamed: "mileyFace")
            pointValue = 2
        }
        
        
        labelScore.text = "\(score)"
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
        labelClock.removeAllActions()
        gsDelegate?.gameHasFinished(withFinalScore: score, scene: self)
    }
    
        
}
