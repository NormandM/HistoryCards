//
//  Levels.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-11.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
struct Level {
    let level: String
    let upLevelPoints: String
    let addedCoins: Int
    let nextLevel: String
    let nextLevelPoints: Int
    let points = UserDefaults.standard.integer(forKey: "points")
    init() {
        switch points {
        case 0..<100:
            level = "Initital level"
            upLevelPoints = "0"
            addedCoins = 0
            nextLevel = "History Amateur"
            nextLevelPoints = 100
        case 100..<500:
            level = "History Amateur"
            upLevelPoints = "3"
            addedCoins = 50
            nextLevel = "History Conoisseur"
            nextLevelPoints = 500
        case 500..<1000:
            level = "History Conoisseur"
            upLevelPoints = "1000"
            addedCoins = 100
            nextLevel = "History Expert"
            nextLevelPoints = 1000
        case 1000..<2000:
            level = "History Expert"
            upLevelPoints = "2000"
            addedCoins = 200
            nextLevel = "History Scholar"
            nextLevelPoints = 2000
        case 2000..<3000:
            level = "History Scholar"
            upLevelPoints = "3000"
            addedCoins = 300
            nextLevel = "History Master"
            nextLevelPoints = 3000
        case 3000..<5000:
            level = "History Master"
            upLevelPoints = "5000"
            addedCoins = 500
            nextLevel = "This is the last level"
            nextLevelPoints = 3000
        case 5000..<10000000000000:
            level = "History Master"
            upLevelPoints = "5000"
            addedCoins = 500
            nextLevel = "History Guru"
            nextLevelPoints = 5000
        default:
            level = "History Master"
            upLevelPoints = "5000"
            addedCoins = 500
            nextLevel = "History Guru"
            nextLevelPoints = 5000
            
        }
    }
}
func achievement() -> Bool {
    let level = Level()
    if (level.level != UserDefaults.standard.string(forKey: "level") && level.level != "Initital level"){
        UserDefaults.standard.set(level.level, forKey: "level")
        return true
    }else{
        return false
    }
}
