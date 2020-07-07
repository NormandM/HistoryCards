//
//  CoinAndPoints.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-01.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
func addCoins(numberOfCoinsToAdd: Int) -> Bool{
    var coins = UserDefaults.standard.integer(forKey: "coins")
    UserDefaults.standard.set(coins + numberOfCoinsToAdd, forKey: "coins")
    coins =  UserDefaults.standard.integer(forKey: "coins")
    if coins > 400 && !UserDefaults.standard.bool(forKey: "sixHundredCoinsReached") {
        return true
    }else{
        return false
    }
}
func addPoints(numberOfPointsToAdd: Int) {
    let points = UserDefaults.standard.integer(forKey: "points")
    UserDefaults.standard.set(points + numberOfPointsToAdd, forKey: "points")
}
func removeCoins(numberOfCoinsToRemove: Int) -> Bool{
    let coins = UserDefaults.standard.integer(forKey: "coins")
    UserDefaults.standard.set(coins - numberOfCoinsToRemove, forKey: "coins")
    if UserDefaults.standard.integer(forKey: "coins") < 0 {
        return true
    }else{
        return false
    }
}
func removePoints(numberOfPointsToRemove: Int){
    let points = UserDefaults.standard.integer(forKey: "points")
    UserDefaults.standard.set(points - numberOfPointsToRemove, forKey: "points")
}
