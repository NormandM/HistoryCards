//
//  ClockDetailViewModel.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-28.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
class ClockDetailViewModel: ObservableObject {
    @Published  var seconds = 0
    @Published var time0 = false
    private var subscriber: AnyCancellable?
    func setup(timeRemaining: Int) {
        self.seconds = 0
        self.time0 = false
        self.subscriber = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { _ in
                if self.seconds < timeRemaining {
                    self.seconds += 1
                }else{
                    self.seconds = timeRemaining
                    self.time0 = true
                }
            })
    }

    func cleanup() {
        self.subscriber = nil
    }
}
