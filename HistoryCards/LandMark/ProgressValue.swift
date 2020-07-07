//
//  ProgressValue.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-07-05.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
class ProgressValue: ObservableObject {
    @Published var value: Float
    @Published var nextLevelPoint: Int
    @Published var nextLevel: String
    var level = Level()
    init() {
      value = Float(UserDefaults.standard.integer(forKey: "points"))/Float(self.level.nextLevelPoints)
        nextLevelPoint = self.level.nextLevelPoints
        nextLevel = self.level.level
    }
}
