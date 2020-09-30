//
//  TumbsUpMessage.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-09-22.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct TumbsUpMessage: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("Pouce haut2")
                    .resizable()
                    .frame(width: geo.size.height/2.2, height: geo.size.height/2)
                    .cornerRadius(25)
                VStack {
                    Spacer()
                    HStack() {
                        Text("+2: ")
                            .foregroundColor(.white)
                            .padding(.leading)
                        VStack {
                            Image("FinalCoin").renderingMode(.original)
                                .resizable()
                                .frame(width: geo.size.height/20
                                    , height: geo.size.height/20)
                            Text("\(UserDefaults.standard.integer(forKey: "coins")) coins")
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        Text("+5: ")
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
                .frame(width: geo.size.height/2.3, height: geo.size.height/2.3)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        
    }
}

struct TumbsUpMessage_Previews: PreviewProvider {
    static var previews: some View {
        TumbsUpMessage()
    }
}
