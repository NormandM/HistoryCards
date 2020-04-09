//
//  ContentView.swift
//  HistoryQuizDevelopment5
//
//  Created by Normand Martin on 2020-02-24.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    let fonts = FontsAndConstraintsOptions()
    @State private var cardFrames = [CGRect](repeating: .zero, count: 3)
    @State private var trayCardsFrames = [CGRect](repeating: .zero, count: 3)
    @State private var xOffset0 = CGFloat()
    @State private var xOffset2 = CGFloat()
    @State private var badAnsweOffset = CGFloat()
    @State private var rightCardPosition  = CGFloat()
    @State private var centerCardPosition  = CGFloat()
    @State private var leftCardPosition  = CGFloat()
    @State private var answerIsGood = false
    @State private var trayIndex = 0
    @State private var cardOpacity = 1.0
    @State private var eventIsEarlier = false
    @State private var questionNumber = 0
    @State private var cardSelected = false
    @State private var cardDropped = false
    @State private var cardDescription = ""
    @State private var nextViewPresent = false
    @State private var percentComplete: CGFloat = 0.0
    @State private var tryAgain = false
    @State private var timeRemaining = 120
    @State private var quizStarted = false
    @State private var messageAfterAnswer = ""
    @State private var firstLevelFinished = false
    @State private var numberCardsDisplayed = false
    @State private var timer0 = false
    @ObservedObject var names = Names()
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State private var points = UserDefaults.standard.integer(forKey: "points")
    @State private var eventName = UserDefaults.standard.string(forKey: "eventName")
    @State private var sequenceName = UserDefaults.standard.string(forKey: "sequenceName")
    @State private var dismissView = UserDefaults.standard.bool(forKey: "dismissView")
    @State private var quizName = UserDefaults.standard.string(forKey: "quizName")
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var eventTiming = EventTiming()
    @State var cardInfo = CardInfo()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var sequence = Sequence()

    var item: NameItem

    var body: some View {
        //  NavigationView {
        GeometryReader { geo in
            ZStack {
                NavigationLink(destination: TimeLineView(), isActive: self.$nextViewPresent){
                    Text("")
                }
                Image("Pouce haut2")
                    .resizable()
                    .frame(width: geo.size.height/2.5, height: geo.size.height/2.5)
                    .cornerRadius(25)
                    .opacity(self.firstLevelFinished ? 1.0 : 0.0)
                VStack() {
                    Spacer()
                    Spacer()
                    HStack {
                        ZStack {
                            Text(self.cardDescription)
                                .lineLimit(100)
                                .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: geo.size.width/1.0
                                    , height: geo.size.height/7.0
                            )
                                .background(ColorReference.specialGray)
                                .cornerRadius(20)
                                .padding()
                            if self.answerIsGood && self.cardDropped{
                                Text(self.messageAfterAnswer)
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialGreen : .clear)
                                Ellipse()
                                    .trim(from: 0, to: self.percentComplete)
                                    .stroke( ColorReference.specialGreen, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .frame(width: geo.size.height/8.0, height:  geo.size.height/8.0)
                                    .animation(.easeOut(duration: 2.0))
                                    .onAppear {
                                        self.percentComplete = 1.0
                                        self.cardDescription = ""
                                        self.numberCardsDisplayed = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                            self.cardDescription = "Cards left: \(self.cardInfo.info.count - self.questionNumber)"
                                            
                                        }
                                }
                            }else if !self.answerIsGood && self.cardDropped{
                                Text(self.messageAfterAnswer)
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialRed : .clear)
                                Ellipse()
                                    .trim(from: 0, to: self.percentComplete)
                                    .stroke( ColorReference.specialRed, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .frame(width: geo.size.height/8, height:  geo.size.height/8)
                                    .animation(.easeOut(duration: 2.0))
                                    .onAppear {
                                        self.percentComplete = 1.0
                                        self.cardDescription = ""
                                }
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Spacer()
                        VStack{
                            Card(onEnded: self.cardDropped, index: 0, text: self.cardInfo.info[self.questionNumber].card0Name)
                                .frame(width: geo.size.height/5 * 0.6
                                    , height: geo.size.height/5)
                                
                                .zIndex(1.0)
                                .overlay(GeometryReader { geo2 in
                                    Color.clear
                                        .coordinateSpace(name: "RightCard")
                                        .onAppear{

                                             self.rightCardPosition = geo2.frame(in: .named("RightCard")).midX
                                            self.cardFrames[0] = geo2.frame(in: .global)
                                    }

                                    .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            self.cardFrames[0] = geo2.frame(in: .global)
                                            self.rightCardPosition = geo2.frame(in: .named("RightCard")).midX
                                        }
                                    }
                                })
                                
                                .opacity(self.answerIsGood && self.self.eventTiming.timing[self.questionNumber].eventIsEarlier ? 1.0 : 0.0)
                                .offset(x: self.answerIsGood && self.cardSelected   ? self.xOffset0 : -self.badAnsweOffset)
                                .addBorder(!self.answerIsGood ? Color.white : Color.clear, cornerRadius: 10)
                                .padding()
                            
                            Text(self.cardInfo.info[self.questionNumber].card0Date)
                                .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension)
                                .foregroundColor(.white)
                            .opacity(self.answerIsGood && self.self.eventTiming.timing[self.questionNumber].eventIsEarlier ? 1.0 : 0.0)
                            
                            
                        }
                        .zIndex(1.0)
                        Spacer()
                        VStack {
                            Card(onEnded: self.cardDropped, index: 1, text:  self.cardInfo.info[self.questionNumber].card1Name)
                                .frame(width: geo.size.height/5 * 0.6
                                    , height: geo.size.height/5)
                                .zIndex(-1.0)
                                .coordinateSpace(name: "CenterCard")
                                .allowsHitTesting(false).overlay(GeometryReader { geo2 in
                                    Color.clear
                                        .onAppear {
                                            
                                            self.cardFrames[1] = geo2.frame(in: .global)
                                            self.centerCardPosition = geo2.frame(in: .named("CenterCard")).midX
                                    }
                                    .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            self.cardFrames[1] = geo2.frame(in: .global)
                                            self.centerCardPosition = geo2.frame(in: .named("CenterCard")).midX
                                        }
                                    
                                    }
                                })
                                .offset(x: self.answerIsGood && self.cardSelected   ? 0 : self.badAnsweOffset)
                                .padding()
                            
                            Text(self.cardInfo.info[self.questionNumber].card1Date)
                                .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension)
                                .foregroundColor(.white)
                        }

                        Spacer()
                        VStack{
                            Card(onEnded: self.cardDropped, index: 2, text:  self.cardInfo.info[self.questionNumber].card2Name)
                                .frame(width: geo.size.height/5 * 0.6
                                    , height: geo.size.height/5)
                                .zIndex(1.0)
                                .coordinateSpace(name: "LeftCard")
                                .allowsHitTesting(false).overlay(GeometryReader { geo2 in
                                    Color.clear
                                        .onAppear {
                                            self.cardFrames[2] = geo2.frame(in: .global)
                                            self.leftCardPosition = geo2.frame(in: .named("LeftCard")).midX
                                            
                                    }
                                    .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            self.cardFrames[2] = geo2.frame(in: .global)
                                            self.leftCardPosition = geo2.frame(in: .named("LeftCard")).midX
                                        }
                                    }
                                })
                                .opacity(self.answerIsGood && !self.self.eventTiming.timing[self.questionNumber].eventIsEarlier ? 1.0 : 0.0)
                                .offset(x: self.answerIsGood && self.cardSelected ? self.xOffset2 : self.badAnsweOffset)
                                .addBorder(!self.answerIsGood ? Color.white : Color.clear, cornerRadius: 10)
                                .padding()
                            Text(self.cardInfo.info[self.questionNumber].card2Date)
                                .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension)
                                .foregroundColor(.white)
                           .opacity(self.answerIsGood && !self.self.eventTiming.timing[self.questionNumber].eventIsEarlier ? 1.0 : 0.0)
                        }

                        Spacer()
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed ,index: 0, text:  self.cardInfo.info[self.questionNumber].trayCard0Name)
                            .frame(width: geo.size.height/5 * 0.6
                                , height: geo.size.height/5)
                            .opacity(self.trayIndex == 0 && self.answerIsGood ? 0 :  self.cardOpacity)
                            .offset(x: self.answerIsGood && self.cardSelected   ? 0.0 : self.badAnsweOffset)
                            .zIndex(1.0)
                            .padding()
                    }
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(ColorReference.specialGray)
                            .frame(width: geo.size.width, height: geo.size.height/7
                        )
                        HStack(alignment: .bottom){
                            Spacer()
                            VStack{
                                ZStack{
                                    Circle()
                                        .foregroundColor(ColorReference.specialOrange)
                                        .frame(width: geo.size.height/12
                                            , height: geo.size.height/12)
                                    
                                    Text("\(self.timeRemaining)")
                                        .onReceive(self.timer) { _ in
                                            if self.timeRemaining  > 0 && self.quizStarted {
                                                self.timeRemaining -= 1
                                            }else if self.timeRemaining  == 0 && self.quizStarted {
                                                self.cardAnimation()
                                                self.timer0 = true
                                            }
                                    }
                                    .background(ColorReference.specialOrange)
                                    .scaledFont(name: "Helvetica Neue", size: self.fonts.finalBigFont)
                                }
                                Text("Time left")
                                    .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension )
                            }
                            Spacer()
                            VStack {
                                Button(action: {
                                    print()
                                }){
                                    Image("FinalCoin").renderingMode(.original)
                                        .resizable()
                                        .frame(width: geo.size.height/12
                                            , height: geo.size.height/12)
                                }
                                
                                Text("\(self.coins) coins")
                                    .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension )
                            }
                            Spacer()
                            VStack{
                                ZStack{
                                    Circle()
                                        .foregroundColor(ColorReference.specialOrange)
                                        .frame(width: geo.size.height/12
                                            , height: geo.size.height/12)
                                    Text("\(self.points)")
                                        .background(ColorReference.specialOrange)
                                        .scaledFont(name: "Helvetica Neue", size: self.fonts.finalBigFont)
                                }
                                Text("Score")
                                    .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension )
                            }
                            Spacer()
                        }
                    }
                }.blur(radius: self.firstLevelFinished ?  75 : 0.0)
                    .zIndex(-0.5)
                
            }
        }
        .onAppear{
            self.coins = UserDefaults.standard.integer(forKey: "coins")
            self.eventName = self.item.cardInfoName
            self.nextViewPresent = false
            UserDefaults.standard.set(self.eventName, forKey: "eventName")
            self.sequenceName = self.item.sequenceName
            UserDefaults.standard.set(self.sequenceName, forKey: "sequenceName")
            self.sequence = Sequence()
            self.cardInfo = CardInfo()
            self.eventTiming = EventTiming()
            self.dismissView = UserDefaults.standard.bool(forKey: "dismissView")
            print("dismissView: \(self.dismissView)")
            if self.dismissView {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .background(ColorReference.specialGreen)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Earlier or Later", displayMode: .inline)
        .navigationBarHidden(self.firstLevelFinished)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())

    }
    // Functions
    func cardDropped(location: CGPoint, trayIndex: Int, cardAnswer: String){
        if let match = cardFrames.firstIndex(where: {
            $0.contains(location)
        }) {
            cardDropped = true
            switch match {
            
            case 0:
                if  self.eventTiming.timing[self.questionNumber].eventIsEarlier{
                    answerIsGood = true
                    playSound(sound: "chime_clickbell_octave_up", type: "mp3")
                    self.points += 1
                    UserDefaults.standard.set(self.points, forKey: "points")
                    withAnimation(Animation.easeInOut(duration: 2).delay(1)) {
                        self.xOffset0 = centerCardPosition - rightCardPosition
                    }
                }else{
                    self.coins -= 1
                    UserDefaults.standard.set(self.coins, forKey: "coins")
                    answerIsGood = false
                    playSound(sound: "Error Warning", type: "wav")
                }
            case 2:
                if !self.eventTiming.timing[self.questionNumber].eventIsEarlier {
                    answerIsGood = true
                    playSound(sound: "chime_clickbell_octave_up", type: "mp3")
                    self.points += 1
                    UserDefaults.standard.set(self.points, forKey: "points")
                    withAnimation(Animation.easeInOut(duration: 2.0).delay(1.0)) {
                        self.xOffset2 = centerCardPosition - leftCardPosition
                    }
                }else{
                    self.coins -= 1
                    UserDefaults.standard.set(self.coins, forKey: "coins")
                    answerIsGood = false
                    playSound(sound: "Error Warning", type: "wav")
                }
            default:
                print("bad")
            }
        }
        cardAnimation()
    }
    func cardMoved(location: CGPoint, letter: String) -> DragState {
        if let match = cardFrames.firstIndex(where: {
            $0.contains(location)
            
        }) {
            if match == 0 || match == 2 {
                return .good
            }else{
                return .bad
            }
        }
        else {
            return .unknown
        }
    }
    func cardPushed(location: CGPoint, trayIndex: Int){
        self.numberCardsDisplayed = false
        self.timer0 = false
        quizStarted = true
        tryAgain = false
        cardSelected = true
        cardDescription = self.cardInfo.info[self.questionNumber].trayCardDescription1
    }
    func cardUnpushed(location: CGPoint, trayIndex: Int) {
        self.numberCardsDisplayed = true
        self.cardDescription = "Cards left: \(9 - self.questionNumber)"
    }
    func cardAnimation () {
        self.tryAgain = true
        if answerIsGood && !timer0{
            self.messageAfterAnswer = "Great!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.questionNumber = self.questionNumber + 1
                self.answerIsGood = false
                self.cardDropped = false
                self.cardOpacity = 1.0
                self.cardSelected = false
                self.xOffset0 = 0
                self.xOffset2 = 0
                self.percentComplete = 0
                if self.questionNumber == self.eventTiming.timing.count - 1 {
              // if self.questionNumber == 2 {
                    withAnimation(.linear(duration: 3)){
                        self.firstLevelFinished = true
                    }
                    self.quizStarted = false
                    self.coins += 2
                    self.points += 5
                    UserDefaults.standard.set(self.coins, forKey: "coins")
                    UserDefaults.standard.set(self.points, forKey: "points")
                    playSound(sound: "music_harp_gliss_up", type: "wav")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        self.nextViewPresent = true
                        self.firstLevelFinished = false
                        self.questionNumber = 0
                        self.cardDescription = "Cards left: \(9 - self.questionNumber)"
                        self.timer.upstream.connect().cancel()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        self.dismissView = true
                    }
                }
            }
        }else{
            self.answerIsGood = false
            self.messageAfterAnswer = "Sorry..."
            withAnimation(.linear(duration: 2)) {
                self.badAnsweOffset = 500
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.cardSelected = false
                self.cardDropped = false
                self.percentComplete = 0
                self.questionNumber = 0
                self.badAnsweOffset = 0
                self.xOffset0 = 0
                self.xOffset2 = 0
                self.quizStarted = false
                self.timeRemaining = 120
                if self.timer0 {
                    self.cardDescription = "Time out. Try again!"
                }else{
                    self.cardDescription  = "Try again!"
                }
            }
        }
    }
    func getFont(tryAgain: Bool) -> CGFloat {
        if tryAgain {
            return fonts.finalBigFont
        }else{
            return fonts.fontDimension
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(item: NameItem.init(cardInfoName: "", sequenceName: ""))
    }
}
