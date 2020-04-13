//
//  SectionRow.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-04-10.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct SectionRow: View {
    var name: Names
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Image(self.name.photo)
                        .resizable()
                        .frame(width: geo.size.height * 0.9, height: geo.size.height * 0.9, alignment: .leading)
                    Text(self.name.name)
                    Spacer()
                }.padding(0).background(FillAll(color: ColorReference.specialOrange))
                
            }

        }
        
    }
}

struct SectionRow_Previews: PreviewProvider {
    var name: Names
    static var previews: some View {
        SectionRow(name: Names(id: UUID(), name: "example", photo: "AmericainRevolution"))
    }
}

struct FillAll: View {
    let color: Color

    var body: some View {
        GeometryReader { proxy in
            self.color.frame(width: proxy.size.width * 1.3, height: proxy.size.height * 1.4).fixedSize()
        }
    }
}
