//
//  LandMarkView.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-10.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct LandMarkView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var progressValue: Float = 0.5
    @State var level = Level()
    @State private var points = UserDefaults.standard.integer(forKey: "points")
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Group{
                        HStack{
                            Spacer()
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
                                
                            }){
                                Text("Done")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                    .padding()
                                    .padding()
                            }
                            .padding()
                        }
                        Text("Congratulation!")
                            .foregroundColor(.white)
                            .font(.title)
                        Text("You have achieved the level:")
                            .foregroundColor(.white)
                            .font(.headline)
                        Text(UserDefaults.standard.string(forKey: "level")!)
                            .foregroundColor(ColorReference.specialOrange)
                            .font(.largeTitle)
                            .padding(.top)
                    }
                    Image(self.level.level)
                        .resizable()
                        .frame(width: geo.size.height/3.0, height: geo.size.height/3.0)
                    HStack{
                        Text("+ \(String(self.level.addedCoins)) coins")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                        VStack {
                            Image("FinalCoin").renderingMode(.original)
                                .resizable()
                                .frame(width: geo.size.height/12
                                    , height: geo.size.height/12)
                            Text("\(UserDefaults.standard.integer(forKey: "coins") + self.level.addedCoins)")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                    }
                    HStack{
                        ProgressBar().frame(width: geo.size.height/3.4, height: geo.size.height * 0.01)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    Spacer()
                }
            }
        }
        .background(ColorReference.specialRed)
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            _ = addCoins(numberOfCoinsToAdd: self.level.addedCoins)
            playSound(sound: "fanfare", type: "mp3")
        }
    }
    
    struct LandMarkView_Previews: PreviewProvider {
        static var previews: some View {
            LandMarkView()
        }
    }
}
