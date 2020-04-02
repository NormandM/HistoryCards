//
//  Data.swift
//  HistoryQuizDevelopement2
//
//  Created by Normand Martin on 2020-01-08.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
import SwiftUI
struct Event {
    let name: String
    let description: String
    let date: String
    let eventIndex: Int
    let allEvents: [[String]]
    init(eventIndex: Int) {
        let pListEvent = UserDefaults.standard.string(forKey: "eventName")
        if let plistPath = Bundle.main.path(forResource: pListEvent, ofType: "plist"),
            let transition = NSArray(contentsOfFile: plistPath){
            allEvents = transition as! [[String]]
        }else{
            allEvents = []
        }
        self.eventIndex = eventIndex
        name = allEvents[eventIndex][1]
        description = allEvents[eventIndex][2]
        date = allEvents[eventIndex][0]
    }
}
