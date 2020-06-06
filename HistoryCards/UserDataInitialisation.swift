//
//  UserDataInitialisation.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-04-18.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
struct UserDataInitialisation {
    static let eras = UserDefaults.standard.array(forKey: "EF1CC5BB-4785-4D8E-AB98-5FA4E00B6A66") as! [Bool]
    static let he = UserDefaults.standard.array(forKey: "94179694-9E99-4AF9-976C-30DAD9E8995D") as! [Bool]
    static let ancientCivilisations = UserDefaults.standard.array(forKey: "3D97FAB4-50AC-40FC-9BF0-3F46BB6A92F5") as! [Bool]
    static let revolutions = UserDefaults.standard.array(forKey: "1C89DAFD-7653-4EF2-BF20-C51A159BAC43") as! [Bool]
    static let americainRevolution = UserDefaults.standard.array(forKey: "CE3C67F9-79E3-46E3-B134-362A52ABFE3C") as! [Bool]
    static let frenchRevolution = UserDefaults.standard.array(forKey: "72A67ED4-7CF8-11EA-BC55-0242AC130003") as! [Bool]
    static let wars = UserDefaults.standard.array(forKey: "6F2D0E08-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    static let napoleon = UserDefaults.standard.array(forKey: "DF3685AA-7D9B-11EA-BC55-0242AC130003") as! [Bool]
    static let americainCivilWar = UserDefaults.standard.array(forKey: "6F2D14E8-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    static let ww1 = UserDefaults.standard.array(forKey: "6F2D192A-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    static let ww2 = UserDefaults.standard.array(forKey: "6F2D1B82-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    static let space = UserDefaults.standard.array(forKey: "6F2D1EAC-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    
    static func initialValue () {
        UserDefaults.standard.set([false, false, false], forKey: "EF1CC5BB-4785-4D8E-AB98-5FA4E00B6A66")
        UserDefaults.standard.set([false, false, false, false], forKey: "94179694-9E99-4AF9-976C-30DAD9E8995D")
        UserDefaults.standard.set([false, false, false, false], forKey: "3D97FAB4-50AC-40FC-9BF0-3F46BB6A92F5")
        UserDefaults.standard.set([false, false, false], forKey: "1C89DAFD-7653-4EF2-BF20-C51A159BAC43")
        UserDefaults.standard.set([false, false, false], forKey: "CE3C67F9-79E3-46E3-B134-362A52ABFE3C")
        UserDefaults.standard.set([false, false, false], forKey: "72A67ED4-7CF8-11EA-BC55-0242AC130003")
        UserDefaults.standard.set([false, false, false, false, false], forKey: "6F2D0E08-7B4A-11EA-BC55-0242AC130003")
        UserDefaults.standard.set([false, false, false], forKey: "DF3685AA-7D9B-11EA-BC55-0242AC130003")
        UserDefaults.standard.set([false, false, false], forKey: "6F2D14E8-7B4A-11EA-BC55-0242AC130003")
        UserDefaults.standard.set([false, false], forKey: "6F2D192A-7B4A-11EA-BC55-0242AC130003")
        UserDefaults.standard.set([false, false, false], forKey: "6F2D1B82-7B4A-11EA-BC55-0242AC130003")
        UserDefaults.standard.set([false, false, false, false], forKey: "6F2D1EAC-7B4A-11EA-BC55-0242AC130003")
    }
}
