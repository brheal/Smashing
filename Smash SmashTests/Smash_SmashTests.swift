//
//  Smash_SmashTests.swift
//  Smash SmashTests
//
//  Created by Timothy Barrett on 4/27/16.
//  Copyright © 2016 Timothy Barrett. All rights reserved.
//

import XCTest
@testable import Smash_Smash

class GameStoreTests:XCTestCase {
    func testUploadScore() {
        let exp = expectationWithDescription("upload new random score to server")
        GameStore.shared.uploadScore(withPlayerName: "test_player", withScore: Int(rand())) { (success, err) in
            XCTAssertTrue(success)
            XCTAssertNil(err)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testRetrieveScore() {
        let exp = expectationWithDescription("get leaderboard")
        GameStore.shared.getTopScores { (leaders, error) in
            XCTAssertNil(error)
            print(leaders)
            exp.fulfill()
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
}
