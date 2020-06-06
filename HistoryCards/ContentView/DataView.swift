//
//  DataView.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-04-16.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct DataView: View {
    let fonts = FontsAndConstraintsOptions()
    @State private var eventName = UserDefaults.standard.string(forKey: "eventName")
    var item: NameItem
    var section: Names
    @State private var eventNumber = 0
    @State private var info = infoForSlideShow(id: 0)
    @State private var isPaused = false
    @Environment(\.presentationMode) var presentationMode
    var vm: ClockDetailViewModel
    @State private var count = 0
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Spacer()
                    Spacer()
                    HStack{
                        Text(self.info.name)
                            .foregroundColor(.white)
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    Text(self.info.description)
                        .lineLimit(100)
                        .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension)
                        .foregroundColor(.black)
                        .padding()
                        .frame(width: geo.size.width/1.0
                            , height: geo.size.height/7.0
                    )
                        .background(ColorReference.specialGray)
                        .cornerRadius(20)
                        .padding()
                    Text(self.info.date)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    Image(self.section.photoHD)
                        .resizable()
                        .frame(width: geo.size.height/2.5, height: geo.size.height/2.5)
                        .cornerRadius(25)
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(ColorReference.specialGray)
                            .frame(width: geo.size.width, height: geo.size.height/10
                        )
                        Button(action: {
                            self.isPaused = !self.isPaused
                        }){
                            Image(systemName: self.isPaused  ?  "play.fill" : "pause.fill" )
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: geo.size.height/20
                                    , height: geo.size.height/20
                            )
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: goBack) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                    Text("Quiz")
                        .foregroundColor(.white)
                }
            }
        )
            .navigationBarTitle("\(String(self.eventNumber + 1)) of 6")
            .background(ColorReference.specialGreen)
            .edgesIgnoringSafeArea(.all)
            .navigationViewStyle(StackNavigationViewStyle())
            .onReceive(self.vm.objectWillChange){_ in
                self.count += 1
                if self.count > 5 {
                    if self.eventNumber < 5 && !self.isPaused {
                        self.eventNumber += 1
                    }else if self.eventNumber == 5 {
                        self.isPaused = true
                        self.eventNumber = 0
                    }
                    self.info = infoForSlideShow(id: self.eventNumber)
                    self.count = 0
                }
        }
    }
    func goBack(){
        self.presentationMode.wrappedValue.dismiss()
    }
}

//struct DataView_Previews: PreviewProvider {
//    static var previews: some View {
//        DataView( item: NameItem.example, section: Names.example)
//    }
//}
