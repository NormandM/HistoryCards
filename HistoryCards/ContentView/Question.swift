//
//  Question.swift
//  HistoryQuizDevelopement3
//
//  Created by Normand Martin on 2020-02-08.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine


struct Sequences  {
    let trayCards: [Int]
    let eventIsEarlier: [Bool]
    let sequences: [[Int]]
    let sequence = Sequence()
    init() {
        let sequence = Sequence()
        trayCards = sequence.trayCards
        eventIsEarlier = sequence.isEarlier
        sequences = sequence.sequence
    }
}


class Info: Identifiable {
    var id: Int
    var card0Name: String
    var card1Name: String
    var card2Name: String
    var card0Date: String
    var card1Date: String
    var card2Date: String
    var trayCard0Name: String
    var trayCardDescription1: String
    var trayCards: String
    var questionNumber: String
    init(id: Int) {
        let sequences = Sequences()
        self.id = id
        card0Name = Event(eventIndex: sequences.sequences[id][0]).name
        card1Name = Event(eventIndex: sequences.sequences[id][1]).name
        card2Name = Event(eventIndex: sequences.sequences[id][2]).name
        trayCard0Name = Event(eventIndex: sequences.trayCards[id]).name
        trayCards = Event(eventIndex: sequences.trayCards[id]).name
        trayCardDescription1 = Event(eventIndex: sequences.trayCards[id]).description
        card0Date = Event(eventIndex: sequences.sequences[id][0]).date
        card1Date = Event(eventIndex: sequences.sequences[id][1]).date
        card2Date = Event(eventIndex: sequences.sequences[id][2]).date
        questionNumber = String(id)
    }
}
class Timing: Identifiable {
    var id: Int
    var eventIsEarlier: Bool
    init(id: Int) {
        let sequences = Sequences()
        self.id = id
        eventIsEarlier = sequences.eventIsEarlier[id]
    }
}

class CardInfo {
    var info : [Info]
    
    init() {
        let sequence = Sequences()
        let totalNumber = sequence.trayCards.count
        var arrayOfquestions = [Info]()
        for n in 0...totalNumber - 1{
            arrayOfquestions.append(Info(id: n))
        }
        self.info = arrayOfquestions
    }
}
class EventTiming  {
    var timing : [Timing]
    init() {
        var arrayTiming = [Timing]()
        let sequence = Sequences()
        let totalNumber = sequence.trayCards.count
        for n in 0...totalNumber - 1{
            arrayTiming.append(Timing(id: n))
        }
        self.timing = arrayTiming
    }
}
struct infoForSlideShow: Identifiable {
    var id: Int
    var date: String
    var name: String
    var description: String
    init(id: Int){
        self.id = id
        name = Event(eventIndex: id).name
        description = Event(eventIndex: id).description
        date = Event(eventIndex: id).date
    }
}








struct Question_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
