//
//  ProgressBar.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-02.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @State var value: Float
    let level = Level()
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width * 0.8 , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColorReference.specialGray))
                    .opacity(self.value >= 3000 ? 0 : 1)
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width * 0.8, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColorReference.specialOrange))
                    .animation(.linear)
                    .opacity(self.value >= 3000.0 ? 0 : 1)
            }.cornerRadius(45.0)
                .opacity(self.value >= 3000.0 ? 0 : 1)
        }
        .onAppear{
            self.value = Float(UserDefaults.standard.integer(forKey: "points"))/Float(self.level.nextLevelPoints)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 0.5)
    }
}
