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
}

struct NameItem: Identifiable, Codable, Equatable {
    var id: UUID
    let name: String
    let sequence: String
}

//class Sections: Identifiable, ObservableObject {
//    var id = UUID()
//    @Published var sections = [SectionItem]()
//
//}
//struct SectionItem: Identifiable {
//    var id = UUID()
//    let sectionItem: String
//}

