//
//  QuizData.swift
//  HistoryQuizDevelopment5
//
//  Created by Normand Martin on 2020-03-05.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
import SwiftUI
class QuizData: ObservableObject {
    @Published var names: [String]
    @Published var dates: [String]
    @Published var datesCards: [String]
    init() {
        var allData: [[String]]
        let pListEvent =  UserDefaults.standard.string(forKey: "eventName")
        if let plistPath = Bundle.main.path(forResource: pListEvent, ofType: "plist"),
            let transition = NSArray(contentsOfFile: plistPath){
            allData = transition as! [[String]]
        }else{
            allData = []
        }
        var sequence = [Int]()
        for n in 0...allData.count - 1{
            sequence.append(n)
        }
        sequence.shuffle()
        names = [allData[sequence[0]][1], allData[sequence[1]][1], allData[sequence[2]][1]]
        dates = [allData[sequence[0]][0], allData[sequence[1]][0], allData[sequence[2]][0]]
        datesCards = [allData[sequence[0]][0], allData[sequence[1]][0], allData[sequence[2]][0]]
       
        dates.shuffle()
         print(dates)
        print(datesCards)
    }
}
