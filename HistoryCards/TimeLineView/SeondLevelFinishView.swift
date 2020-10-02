//
//  SeondLevelFinishView.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-09-22.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct SeondLevelFinishView: View {
    @Binding var secondLevelFinished: Bool
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Image("Pouce haut3")
                    .resizable()
                    .frame(width: geo.size.height/2.4, height: geo.size.height/2.4)
                    .cornerRadius(25)
                    .opacity(self.secondLevelFinished ? 1.0 : 0.0)
                VStack {
                    Spacer()
                    HStack(alignment: .center) {
                        Text("+5: ")
                            .foregroundColor(.white)
                            .padding(.leading)
                        VStack {
                            Image("FinalCoin").renderingMode(.original)
                                .resizable()
                                .frame(width: geo.size.height/22
                                       , height: geo.size.height/22)
                            Text("\(UserDefaults.standard.integer(forKey: "coins")) coins")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Text("+15: ")
                            .foregroundColor(.white)
                        VStack{
                            Image("points2")
                                .resizable()
                                .frame(width: geo.size.height/22
                                       , height: geo.size.height/22)
                            Text("\(UserDefaults.standard.integer(forKey: "points")) points")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                    }
                }
                .padding()
                .frame(width: geo.size.height/2.2, height: geo.size.height/2.2)
                .opacity(self.secondLevelFinished ? 1.0 : 0.0)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

//struct SeondLevelFinishView_Previews: PreviewProvider {
//    static var previews: some View {
//        SeondLevelFinishView(secondLevelFinished: Binding<Bool>.constant(true))
//    }
//}
