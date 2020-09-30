//
//  ProgressBar.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-02.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @ObservedObject var progressValue = ProgressValue()
    @ObservedObject var level = Level()
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    VStack {
                    Text(self.level.points < 2000 ? "Can you reach the next Level?" : "You have reached the highest level!")
                        .foregroundColor(ColorReference.specialOrange)
                        .font(.subheadline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding(.top)
                        .padding(.top)
                    Text(self.level.nextLevel)
                        .foregroundColor(ColorReference.specialOrange)
                        .font(.subheadline)
                    }
                    .padding(.top)
                    HStack {
                        Text("0")
                            .foregroundColor(.white)
                            .font(.footnote)
                            .frame(width: geometry.size.width * 0.05, height: geometry.size.height * 0.1)
                        ZStack(alignment: .leading) {
                            Rectangle().frame(width: geometry.size.width * 0.6
                                              , height: geometry.size.height)
                                .opacity(0.3)
                                .foregroundColor(Color(UIColorReference.specialGray))
                                .background(Color(UIColorReference.specialGray))
                                .opacity(self.progressValue.value >= 3000 ? 0 : 1)
                            
                            Rectangle().frame(width: min(CGFloat(self.progressValue.value)*geometry.size.width * 0.6, geometry.size.width), height: geometry.size.height)
                                .foregroundColor(Color(UIColorReference.specialOrange))
                                .animation(.linear)
                                .opacity(self.progressValue.value >= 3000.0 ? 0 : 1)
                        }
                        .cornerRadius(45.0)
                        .opacity(self.progressValue.value >= 3000.0 ? 0 : 1)
                        
                        Text(String(self.progressValue.nextLevelPoint))
                            .frame(width: geometry.size.width * 0.1, height: geometry.size.height * 0.1)
                            .foregroundColor(.white)
                            .font(.footnote)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    .frame(width: geometry.size.width * 0.6
                                      , height: geometry.size.height * 0.1)
                    
                    
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

//struct ProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBar()
//    }
//}
