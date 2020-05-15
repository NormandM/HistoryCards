//
//  CoinAndPoints.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-01.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
func addCoins(numberOfCoinsToAdd: Int) {
    let coins = UserDefaults.standard.integer(forKey: "coins")
    UserDefaults.standard.set(coins + numberOfCoinsToAdd, forKey: "coins")
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
