//
//  SectionRow.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-04-10.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI
struct SectionRow: View {
    let name: Names
    let color: Color
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    Image(self.name.photo)
                        .resizable()
                        .frame(width: geo.size.height * 0.9, height: geo.size.height * 0.9, alignment: .leading)
                    
                    Text(self.name.name)
                    Spacer()
                }
                .padding(0).background(FillAll(color: ColorReference.specialOrange))

            }
            .frame(width: geo.size.width, height: geo.size.height)
            .background(ColorReference.specialOrange)
        }
    }
}
struct FillAll: View {
    let color: Color
    var body: some View {
        GeometryReader { proxy in
            self.color.frame(width: proxy.size.width * 1.3, height: proxy.size.height * 1.1).fixedSize()
        }
    }
}
