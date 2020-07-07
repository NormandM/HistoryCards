//
//  Levels.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-11.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
class Level: ObservableObject {
    @Published var level: String
    let upLevelPoints: String
    let addedCoins: Int
    @Published var nextLevel: String
    @Published var nextLevelPoints: Int
    let points = UserDefaults.standard.integer(forKey: "points")
    init() {
        switch points {
        case 0..<100:
            level = "Initital level"
            upLevelPoints = "0"
            addedCoins = 0
            nextLevel = "History Neophyte"
            nextLevelPoints = 100
        case 100..<200:
            level = "History Neophyte"
            upLevelPoints = "3"
            addedCoins = 20
            nextLevel = "History Amateur"
            nextLevelPoints = 200
        case 200..<500:
            level = "History Amateur"
            upLevelPoints = "500"
            addedCoins = 30
            nextLevel = "History Conoisseur"
            nextLevelPoints = 500
        case 500..<1000:
            level = "History Conoisseur"
            upLevelPoints = "1000"
            addedCoins = 40
            nextLevel = "History Expert"
            nextLevelPoints = 1000
        case 1000..<1500:
            level = "History Expert"
            upLevelPoints = "1500"
            addedCoins = 50
            nextLevel = "History Scholar"
            nextLevelPoints = 1500
        case 1500..<2000:
            level = "History Scholar"
            upLevelPoints = "2000"
            addedCoins = 60
            nextLevel = "History Master"
            nextLevelPoints = 2000
        case 2000..<10000000000000:
            level = "History Master"
            upLevelPoints = "2000"
            addedCoins = 100
            nextLevel = ""
            nextLevelPoints = 2000
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
