//
//  Player.swift
//  Smash Smash
//
//  Created by Timothy Barrett on 4/27/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import Foundation

class Player: NSObject {
    static let currentPlayer:Player = Player()
    private(set) var finalScore:Int = 0
    private(set) var playerName:String?
    
    func updatePlayerScore(withNewScore score:Int) {
        finalScore = score
    }
    
    func updatePlayerName(withNewName name:String) {
        playerName = name
    }
    
    func resetPlayer() {
        finalScore = 0
        playerName = ""
    }
}