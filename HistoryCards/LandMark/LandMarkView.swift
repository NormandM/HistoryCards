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
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Group{
                        HStack{
                            Spacer()
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                             //   UserDefaults.standard.set(true, forKey: "dismissView")
                                
                            }){
                                Text("Done")
                                    .font(.footnote)
                                    .foregroundColor(.white)
                                .padding()
                            }
                        }
                            Text("Congratulation!")
                                .foregroundColor(.white)
                                .font(.title)

                        
                        .padding()
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
                            .font(.title)
                            .foregroundColor(ColorReference.specialOrange)
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
                    .padding()
                    }
                    
                    Group {
                        Text("Can you reach the next Level?")
                            .foregroundColor(.white)
                        Text(self.level.nextLevel)
                            .foregroundColor(.white)
                            .font(.title)
                        ProgressBar(value: self.progressValue).frame(height: geo.size.height * 0.02)
                        
                        HStack{
                            Text("0")
                                .foregroundColor(.white)
                                .offset(x: -geo.size.height/5)
                            Text(String(self.level.nextLevelPoints))
                                .foregroundColor(.white)
                                .offset(x: geo.size.height/5)
                        }
                    }
                }
            }


        }
        .background(ColorReference.specialRed)
        .edgesIgnoringSafeArea(.all)
        .onAppear{
                addCoins(numberOfCoinsToAdd: self.level.addedCoins)

            }
        
    
    }
    
    struct LandMarkView_Previews: PreviewProvider {
        static var previews: some View {
            LandMarkView()
        }
    }
}
