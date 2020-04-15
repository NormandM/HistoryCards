//
//  DataModel.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-03-31.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation

struct Names: Identifiable, Codable {
    var id: UUID
    var name: String
    var photo: String
    var items = [NameItem]()
    #if DEBUG
    static let example = Names(id:  UUID(), name: "Eras of the Universe and Man", photo:  "planet-earth", items: [NameItem.example, NameItem.example2])
    #endif
    
}

struct NameItem: Identifiable, Codable, Equatable {
    var id: UUID
    let name: String
    let sequence: String
    
    #if DEBUG
    static let example = NameItem(id: UUID(), name: "Eras1", sequence: "SequenceEras1")
    static let example2 = NameItem(id: UUID(), name: "Eras2", sequence: "SequenceEras2")
    #endif
}


