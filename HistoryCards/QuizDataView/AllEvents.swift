//
//  AllEvents.swift
//  HistoryQuizDevelopment5
//
//  Created by Normand Martin on 2020-03-28.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
struct AllEvents {
    static var event: [EventAndSection]{
        let pListEvent = "InventionsCardData"
        var transitionArray = [[String]]()
        var eventArray = [EventAndSection]()
        if let plistPath = Bundle.main.path(forResource: pListEvent, ofType: "plist"),
            let transition = NSArray(contentsOfFile: plistPath){
            transitionArray = transition as! [[String]]
        }else{
            transitionArray = []
        }
        for event in transitionArray {
            eventArray.append(EventAndSection(date: event[0], items: [EventItem(name: event[1], description: event[2])]))
        }
        return eventArray
    }
}
struct EventAndSection: Codable, Identifiable {
    var id = UUID()
    var date: String
    var items: [EventItem]
}
struct EventItem: Codable, Equatable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
}
