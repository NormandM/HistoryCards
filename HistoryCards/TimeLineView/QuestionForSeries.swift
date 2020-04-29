//
//  QuestionForSeries.swift
//  HistoryQuizDevelopment5
//
//  Created by Normand Martin on 2020-03-02.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
struct Series {
    var list = [[0, 3, 5], [1, 2, 4]]
}
struct SeriesInfo:  Identifiable {
    var id: Int
    var trayCardName: [String]
    var cardName: [String]
    var cardDate: [String]
    var cardDescription: [String]
    var rightPositionCard: [String]
    init(id: Int) {
        self.id = id
        let series = Series()
        let list = series.list[id]
        var arrayName = [String]()
        var arrayDescription = [String]()
        var arrayDate = [String]()
        let shuffledList = list.shuffled()
        var arrayRightPositionCard = [String]()
        for n in 0...2{
            arrayDate.append(Event(eventIndex: shuffledList[n]).date)
            arrayName.append(Event(eventIndex: shuffledList[n]).name)
            arrayDescription.append(Event(eventIndex: shuffledList[n]).description)
            arrayRightPositionCard.append(Event(eventIndex: list[n]).name)
        }
        cardDate = arrayDate
        cardName = arrayName
        trayCardName = arrayName
        cardDescription = arrayDescription
        rightPositionCard = arrayRightPositionCard
    }
}
class QuestionsForSeries: ObservableObject {
    @Published var seriesInfo : [SeriesInfo]
    init() {
        var arraySeriesInfo = [SeriesInfo]()
        for n in 0...1 {
            arraySeriesInfo.append(SeriesInfo(id: n))
        }
        seriesInfo = arraySeriesInfo
    }
    
}

