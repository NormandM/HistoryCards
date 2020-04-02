//
//  DataModel.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-03-31.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
struct NameItem: Identifiable {
    var id = UUID()
    let cardInfoName: String
    let sequenceName: String
    let quizName: String

}
class Names: ObservableObject, Identifiable {
    var id = UUID()
    @Published var items = [NameItem]()
}

