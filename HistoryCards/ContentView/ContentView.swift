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
    @State private var showUpLevel = false
    @State private var showCreditManager = false
    @State private var percentComplete: CGFloat = 0.0
    @State private var tryAgain = false
    @State private var timeRemaining = 120
    @State private var quizStarted = false
    @State private var messageAfterAnswer = ""
    @State private var firstLevelFinished = false
    @State private var numberCardsDisplayed = false
    @State private var timer0 = false
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State private var points = UserDefaults.standard.integer(forKey: "points")
    @State private var eventName = UserDefaults.standard.string(forKey: "eventName")
    @State private var sequenceName = UserDefaults.standard.string(forKey: "sequenceName")
    @State private var dismissView = UserDefaults.standard.bool(forKey: "dismissView")
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var startUp = true
    @State private var seeQuizData = false
    @State private var eventTiming = EventTiming()
    @State var cardInfo = CardInfo()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var sequence = Sequence()
    var item: NameItem
    var section: Names
    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(destination: TimeLineView(item: self.item, section: self.section), isActive: self.$nextViewPresent){
                    Text("")
                }
                NavigationLink(destination: DataView(item: self.item, section: self.section), isActive: self.$seeQuizData){
                    Text("")
                }
                
                if self.startUp{
                    VStack {
                        Spacer()
                        Text("See the time line before the Quiz?")
                            .padding()
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.title)
                        Spacer()
                        Button(action: {
                            self.seeQuizData = true
                            self.startUp = false
                        }){
                            Text(" Yes, let's see ! ")
                                .font(.headline)
                                .padding()
                                .background(ColorReference.specialGreen)
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                            )
                        }
                            
                        .padding()
                        Button(action: {
                            self.seeQuizData = false
                            self.startUp = false
                        }){
                            Text("No, I am ready!")
                                .font(.headline)
                                .padding()
                                .background(ColorReference.specialGreen)
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                            )
                        }
                        .padding()
                        Spacer()
                        Spacer()
                    }
                    
                    
                }else{
                    ZStack() {
                        Image("Pouce haut2")
                            .resizable()
                            .frame(width: geo.size.height/2.2, height: geo.size.height/2)
                            .cornerRadius(25)
                            .opacity(self.firstLevelFinished ? 1.0 : 0.0)
                        VStack {
                            Spacer()
                            HStack(alignment: .center) {
                                Text("+5: ")
                                    .foregroundColor(.white)
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
                            }
                        }
                        .padding()
                        .frame(width: geo.size.height/2.2, height: geo.size.height/2)
                        .opacity(self.firstLevelFinished ? 1.0 : 0.0)
                    }
                }
                VStack() {
                    Spacer()
                    HStack(alignment: .top) {
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
                            if self.answerIsGood && self.cardDropped{
                                Text("+ 1 coin")
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialGreen : .clear)
                                    .offset(x: -geo.size.width/3)
                                Text(self.messageAfterAnswer)
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialGreen : .clear)
                                Text("+ 1 point")
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialGreen : .clear)
                                    .offset(x: geo.size.width/3)
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
                                Text("- 1 coin")
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialRed : .clear)
                                    .offset(x: -geo.size.width/3)
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
                    .padding()
                    HStack {
                        Spacer()
                        VStack{
                            Card(onEnded: self.cardDropped, index: 0, text: self.cardInfo.info[self.questionNumber].card0Name)
                                .frame(width: geo.size.height/4.3 * 0.6
                                    , height: geo.size.height/4.3)
                                
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
                            Text(self.cardInfo.info[self.questionNumber].card0Date)
                                .font(.footnote)
                                .foregroundColor(.white)
                                .opacity(self.answerIsGood && self.self.eventTiming.timing[self.questionNumber].eventIsEarlier ? 1.0 : 0.0)
                        }
                        .zIndex(1.0)
                        Spacer()
                        VStack {
                            Card(onEnded: self.cardDropped, index: 1, text:  self.cardInfo.info[self.questionNumber].card1Name)
                                .frame(width: geo.size.height/4.3 * 0.6
                                    , height: geo.size.height/4.3)
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
                            
                            Text(self.cardInfo.info[self.questionNumber].card1Date)
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        VStack{
                            Card(onEnded: self.cardDropped, index: 2, text:  self.cardInfo.info[self.questionNumber].card2Name)
                                .frame(width: geo.size.height/4.3 * 0.6
                                    , height: geo.size.height/4.3)
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
                            Text(self.cardInfo.info[self.questionNumber].card2Date)
                                .font(.footnote)
                                .foregroundColor(.white)
                                .opacity(self.answerIsGood && !self.self.eventTiming.timing[self.questionNumber].eventIsEarlier ? 1.0 : 0.0)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed ,index: 0, text:  self.cardInfo.info[self.questionNumber].trayCard0Name)
                            .frame(width: geo.size.height/4.3 * 0.6
                                , height: geo.size.height/4.3)
                            .opacity(self.trayIndex == 0 && self.answerIsGood ? 0 :  self.cardOpacity)
                            .offset(x: self.answerIsGood && self.cardSelected   ? 0.0 : self.badAnsweOffset)
                            .zIndex(1.0)
                    }
                    
                    ZStack(alignment: .top){
                        Rectangle()
                            .fill(ColorReference.specialGray)
                            .frame(width: geo.size.width, height: geo.size.height/7
                        )
                        Spacer()
                        HStack(){
                            Spacer()
                            VStack{
                                ZStack{
                                    Circle()
                                        .foregroundColor(ColorReference.specialOrange)
                                        .frame(width: geo.size.height/12
                                            , height: geo.size.height/12)
                                        .padding(.top)
                                    
                                    Text("\(self.timeRemaining)")
                                        .padding(.top)
                                        .onReceive(self.timer) { _ in
                                            if self.timeRemaining  > 0 && self.quizStarted {
                                                self.timeRemaining -= 1
                                            }else if self.timeRemaining  == 0 && self.quizStarted {
                                                self.cardAnimation()
                                                self.timer0 = true
                                            }
                                    }
                                    .background(ColorReference.specialOrange)
                                    .font(.title)
                                }
                                Text("Time left")
                                    .font(.footnote)
                            }
                            Spacer()
                            VStack {
                                Button(action: {
                                    self.showCreditManager = true
                                }){
                                    Image("FinalCoin").renderingMode(.original)
                                        .resizable()
                                        .frame(width: geo.size.height/12
                                            , height: geo.size.height/12)
                                }
                                .padding(.top)
                                
                                Text("\(UserDefaults.standard.integer(forKey: "coins")) coins")
                                    .font(.footnote)
                            }
                            Spacer()
                            VStack{
                                Image("points2")
                                    .resizable()
                                    .frame(width: geo.size.height/12
                                        , height: geo.size.height/12)
                                    .padding(.top)
                                Text("\(UserDefaults.standard.integer(forKey: "points")) points")
                                    .font(.footnote)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                    }
                }.blur(radius: self.firstLevelFinished || self.startUp ?  75 : 0.0)
                    .zIndex(-0.5)
            }
        }
        .onAppear{
            self.coins = UserDefaults.standard.integer(forKey: "coins")
            self.eventName = self.item.name
            self.nextViewPresent = false
            UserDefaults.standard.set(self.eventName, forKey: "eventName")
            self.sequenceName = self.item.sequence
            UserDefaults.standard.set(self.sequenceName, forKey: "sequenceName")
            self.sequence = Sequence()
            self.cardInfo = CardInfo()
            self.eventTiming = EventTiming()
            self.dismissView = UserDefaults.standard.bool(forKey: "dismissView")
            if self.dismissView {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .background(ColorReference.specialGreen)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Earlier or Later", displayMode: .inline)
        .navigationBarHidden(self.firstLevelFinished)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: self.$showUpLevel) {
            LandMarkView()
        }
        .sheet(isPresented: self.$showCreditManager) {
            CoinManagement()
        }
    
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
                    addPoints(numberOfPointsToAdd: 1)
                    addCoins(numberOfCoinsToAdd: 1)
                    withAnimation(Animation.easeInOut(duration: 2).delay(1)) {
                        self.xOffset0 = centerCardPosition - rightCardPosition
                    }
                    self.showUpLevel = achievement()
                }else{
                    showCreditManager = removeCoins(numberOfCoinsToRemove: 1)
                    answerIsGood = false
                    playSound(sound: "Error Warning", type: "wav")
                }
                cardAnimation()
            case 2:
                if !self.eventTiming.timing[self.questionNumber].eventIsEarlier {
                    answerIsGood = true
                    playSound(sound: "chime_clickbell_octave_up", type: "mp3")
                    addPoints(numberOfPointsToAdd: 1)
                    addCoins(numberOfCoinsToAdd: 1)
                    withAnimation(Animation.easeInOut(duration: 2.0).delay(1.0)) {
                        self.xOffset2 = centerCardPosition - leftCardPosition
                    }
                    self.showUpLevel = achievement()
                }else{
                    showCreditManager = removeCoins(numberOfCoinsToRemove: 1)
                    answerIsGood = false
                    playSound(sound: "Error Warning", type: "wav")
                }

                cardAnimation()
            default:
                print("default")
            }

        }
        
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
            return .bad
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
                
                self.xOffset0 = 0
                self.xOffset2 = 0
                self.percentComplete = 0
                if self.questionNumber == self.eventTiming.timing.count - 1{
                    withAnimation(.linear(duration: 3)){
                        self.firstLevelFinished = true
                    }
                    self.quizStarted = false
                    addCoins(numberOfCoinsToAdd: 5)
                    addPoints(numberOfPointsToAdd: 5)
                    playSound(sound: "music_harp_gliss_up", type: "wav")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        self.nextViewPresent = true
                        self.cardSelected = false
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
            return fonts.smallFontDimension
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView( item: NameItem.example, section: Names.example)
    }
}
