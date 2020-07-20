//
//  TimeLineView.swift
//  HistoryQuizDevelopment5
//
//  Created by Normand Martin on 2020-02-28.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI


struct TimeLineView: View {
    let fonts = FontsAndConstraintsOptions()
    @State private var cardFrames = [CGRect](repeating: .zero, count: 4)
    @State private var trayCardsFrames = [CGRect](repeating: .zero, count: 4)
    @State private var cardGood = [false, false, false]
    @State private var trayCardDropped = [false, false, false]
    @State private var trayCardText = ""
    @State private var cardWasDropped = [false, false, false]
    @State private var goQuizView = false
    @State private var cardText = ["", "", "", ""]
    @State private var cardIsBeingMoved = [false, false, false]
    @State private var allCardsDropped = false
    @State private var messageAfterAnswer = ""
    @State private var count = 0
    @State private var tryAgain = false
    @State private var cardIndex = 0
    @State private var timeRemaining = 60
    @State private var quizStarted = false
    @State private var cardDescription = ""
    @State private var serieNumbers = 0
    @State private var xOffset: CGFloat = 0.0
    @State private var xOffset2: CGFloat = 0.0
    @State private var percentComplete: CGFloat = 0.0
    @State private var answerIsGood = false
    @State private var serieNumberDisplayed = false
    @State private var secondLevelFinished = false
    @State private var numberToFinish = 0
    @State private var secondLevelWrong = false
    @State private var trayCardDates = ["", "", "", ""]
    @State private var trayCardDate = String()
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State private var points = UserDefaults.standard.integer(forKey: "points")
    @State private var dismissView = UserDefaults.standard.bool(forKey: "dismissView")
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .coinPurchase
    @State private var trayCard0 = ""
    @State private var trayCard1 = ""
    @State private var trayCard2 = ""
    @State private var description0 = ""
    @State private var description1 = ""
    @State private var description2 = ""
    @State private var cardDate0 = ""
    @State private var cardDate1 = ""
    @State private var cardDate2 = ""
    @State private var timer0 = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var questionForSeries = QuestionsForSeries()
    @State private var screenDimension: CGFloat = 0
    @EnvironmentObject var vm: ClockDetailViewModel
    @State private var seconds: Int = 0
    var item: NameItem
    var section: Names
    var body: some View {
        GeometryReader { geo in
            ZStack {
                NavigationLink(destination: QuizView( item: self.item, section: self.section, value: ProgressValue()), isActive: self.$goQuizView){
                    Text("")
                }
                if self.secondLevelFinished {
                Image("Pouce haut3")
                    .resizable()
                    .frame(width: geo.size.height/2.2, height: geo.size.height/2)
                    .cornerRadius(25)
                    .opacity(self.secondLevelFinished ? 1.0 : 0.0)
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
                    }
                }
                .padding()
                .frame(width: geo.size.height/2.2, height: geo.size.height/2)
                .opacity(self.secondLevelFinished ? 1.0 : 0.0)
                }else if self.timer0 || (self.allCardsDropped && !self.answerIsGood){
//////////////////////////////////////////////
                Image(self.timer0 ? "TimesUp" : "Pouce bas")
                    .resizable()
                    .cornerRadius(25)
                    .opacity(self.timer0 || (self.secondLevelWrong) ? 1.0 : 0)
                    .frame(width: geo.size.height/2.2, height: geo.size.height/2.0)
                VStack {
                    Spacer()
                    HStack {
                        
                        VStack {
                            Text("Back to level 1")
                                .foregroundColor(.white)
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                UserDefaults.standard.set(false, forKey: "dismissView")
                                
                            }){
                                Image("0Coin").renderingMode(.original)
                                    .resizable()
                                    .frame(width: geo.size.height/12
                                        , height: geo.size.height/12)
                            }
                            Text("coins")
                                .foregroundColor(.white)
                        }
                        .padding()
                        Spacer()
                        VStack {
                            Text("Stay on level 2")
                                .foregroundColor(.white)
                            Button(action: {
                                self.vm.setup(timeRemaining: 60)
                                self.secondLevelFinished = false
                                self.timer0 = false
                                self.secondLevelWrong = false
                                self.serieNumbers = 0
                                self.cardDescription = "Try again"
                                self.messageAfterAnswer = ""
                                self.allCardsDropped = false
                                self.percentComplete = 0.0
                                self.quizStarted = false
                                self.timeRemaining = 60
                                for n in 0...2{
                                    self.cardWasDropped[n] = false
                                    self.trayCardDropped[n] = false
                                    self.cardIsBeingMoved[n] = false
                                    self.cardText[n] = ""
                                }
                                self.xOffset2 = 0
                                self.xOffset = 0
                                self.numberToFinish = 0
                                self.showSheet = removeCoins(numberOfCoinsToRemove: 5)
                                self.activeSheet = .coinPurchase
                            }){
                                Image("5Coin").renderingMode(.original)
                                    .resizable()
                                    .frame(width: geo.size.height/12
                                        , height: geo.size.height/12)
                                
                            }
                            Text("coins")
                                .foregroundColor(.white)
                        }.padding()
                    }
                }
                .frame(width: geo.size.height/2.2, height: geo.size.height/2.0)
                .opacity(self.timer0 || (self.allCardsDropped && !self.answerIsGood) ? 1.0 : 0)
                }
                VStack {
                    Spacer()
                    HStack {
                        ZStack {
                            Text(self.cardDescription)
                                .lineLimit(100)
                                .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain || self.serieNumberDisplayed))
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: geo.size.width/1.0, height: geo.size.height/7
                            )
                                .border(Color.white)
                                .background(ColorReference.specialGray)
                                .cornerRadius(20)
                            if self.answerIsGood && self.allCardsDropped{
                                Text("+ 2 coin")
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialGreen : .clear)
                                    .offset(x: -geo.size.width/3)
                                
                                Text(self.messageAfterAnswer)
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialGreen : .clear)
                                Text("+ 2 point")
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialGreen : .clear)
                                    .offset(x: geo.size.width/3)
                                
                                Ellipse()
                                    .trim(from: 0, to: self.percentComplete)
                                    .stroke( ColorReference.specialGreen, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .frame(width: geo.size.height/8.0, height:  geo.size.height/8.0)
                                    .animation(.easeOut(duration: 2.0))
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                            self.percentComplete = 1.0
                                            self.cardDescription = ""
                                        }
                                    }
                            }else if !self.answerIsGood && self.allCardsDropped{
                                Text(self.messageAfterAnswer)
                                    .scaledFont(name: "Helvetica Neue", size: self.getFont(tryAgain: self.tryAgain))
                                    .foregroundColor(self.percentComplete == 1.0 ? ColorReference.specialRed : .clear)
                                Ellipse()
                                    .trim(from: 0, to: self.percentComplete)
                                    .stroke( ColorReference.specialRed, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                    .frame(width: geo.size.height/8, height:  geo.size.height/8)
                                    .animation(.easeOut(duration: 2.0))
                                    .onAppear {
                                         DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                            self.percentComplete = 1.0
                                            self.cardDescription = ""
                                        }
                                        self.serieNumberDisplayed = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                                            self.cardDescription = "Serie 2 of 2"
                                        }
                                }
                            }
                        }
                    }
                   
                    HStack() {
                        Spacer()
                        VStack{
                            Card(onEnded: self.cardDropped, index: 0, text: self.cardText[0])
                                .frame(width: geo.size.height/4.3 * 0.6
                                    , height: geo.size.height/4.3)
                                .allowsHitTesting(false)
                                .overlay(GeometryReader { geo2 in
                                    Color.clear
                                        .overlay(GeometryReader { geo2 in
                                            Color.clear
                                                .onAppear{
                                                    self.cardFrames[0] = geo2.frame(in: .global)
                                            }
                                            .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                                if self.screenDimension > 700000 {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                        self.cardFrames[0] = geo2.frame(in: .global)
                                                    }
                                                }

                                            }
                                            
                                        })
                                })
                                .opacity(self.cardWasDropped[0] ? 1.0 : 0.0)
                                .offset(x: self.serieNumbers == 0 ? self.xOffset : 0.0)
                                .addBorder(self.cardWasDropped[0] ? Color.clear : Color.white, cornerRadius: 10)
                            Text(self.trayCardDates[0])
                                .font(.footnote)
                                .foregroundColor(.white)
                                .opacity(self.allCardsDropped ? 1.0 : 0.0)
                            
                        }
                        Spacer()
                        VStack{
                            Card(onEnded: self.cardDropped, index: 1, text: self.cardText[1])
                                .frame(width: geo.size.height/4.3 * 0.6
                                    , height: geo.size.height/4.3)
                                .allowsHitTesting(false)
                                .overlay(GeometryReader { geo2 in
                                    Color.clear
                                        .overlay(GeometryReader { geo2 in
                                            Color.clear
                                                .onAppear{
                                                    self.cardFrames[1] = geo2.frame(in: .global)
                                            }
                                            .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                                if self.screenDimension > 700000 {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                        self.cardFrames[1] = geo2.frame(in: .global)
                                                    }
                                                }

                                            }
                                            
                                        })
                                })
                                .opacity(self.cardWasDropped[1] ? 1.0 : 0.0)
                                .offset(x: self.serieNumbers == 0 ? self.xOffset : 0.0)
                                .addBorder(self.cardWasDropped[1] ? Color.clear : Color.white, cornerRadius: 10)
                            Text(self.trayCardDates[1])
                                .font(.footnote)
                                .foregroundColor(.white)
                                .opacity(self.allCardsDropped ? 1.0 : 0.0)
                        }
                        
                        Spacer()
                        VStack {
                            Card(onEnded: self.cardDropped, index: 2, text: self.cardText[2])
                                .frame(width: geo.size.height/4.3 * 0.6
                                    , height: geo.size.height/4.3)
                                .allowsHitTesting(false)
                                .overlay(GeometryReader { geo2 in
                                    Color.clear
                                        .overlay(GeometryReader { geo2 in
                                            Color.clear
                                                .onAppear{
                                                    self.cardFrames[2] = geo2.frame(in: .global)
                                            }
                                            .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                                if self.screenDimension > 700000 {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                        self.cardFrames[2] = geo2.frame(in: .global)
                                                    }

                                                }

                                            }
                                        })
                                })
                                .opacity(self.cardWasDropped[2] ? 1.0 : 0.0)
                                .offset(x: self.serieNumbers == 0 ? self.xOffset : 0.0)
                                .addBorder(self.cardWasDropped[2] ? Color.clear : Color.white, cornerRadius: 10)
                            Text(self.trayCardDates[2])
                                .font(.footnote)
                                .foregroundColor(.white)
                                .opacity(self.allCardsDropped ? 1.0 : 0)
                           
                        }
                         Spacer()
                    }
                    HStack {
                        Button(action: {
                            for n in 0...2{
                                self.cardGood[n] = false
                                self.trayCardDropped[n] = false
                                self.cardWasDropped[n] = false
                            }
                            self.trayCardText = ""
                            self.cardText = ["", "", "", ""]
                            self.allCardsDropped = false
                            
                        }){
                            Text("Start Over")
                                .font(.body)
                                .padding()
                                .background(ColorReference.specialGreen)
                                .cornerRadius(40)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                            )
                            
                        }.disabled(self.allCardsDropped)
                    }
                    HStack {
                        Spacer()
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 0, text: self.trayCard0)
                            .frame(width: geo.size.height/4.3 * 0.6
                                , height: geo.size.height/4.3)
                            .overlay(GeometryReader { geo2 in
                                Color.clear
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .onAppear{
                                                self.trayCardsFrames[0] = geo2.frame(in: .global)
                                        }
                                        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                            if self.screenDimension > 700000 {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                    self.trayCardsFrames[0] = geo2.frame(in: .global)
                                                }
                                            }

                                        }
                                    })
                            })
                            .zIndex(self.cardIsBeingMoved[0] ? 1.0 : 0.5)
                            .offset(x: self.serieNumbers == 0 ? self.xOffset : 0)
                            .offset(x: self.serieNumbers == 1 ? self.xOffset2 : 0)
                            .opacity(self.trayCardDropped[0] ? 0.0 : 1.0)
                        Spacer()
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 1, text: self.trayCard1)
                            .frame(width: geo.size.height/4.3 * 0.6
                                , height: geo.size.height/4.3)
                            .overlay(GeometryReader { geo2 in
                                Color.clear
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .onAppear{
                                                self.trayCardsFrames[1] = geo2.frame(in: .global)
                                        }
                                        .onReceive(NotificationCenter.Publisher(center: .default, name:
                                            UIDevice.orientationDidChangeNotification)) { _ in
                                                if self.screenDimension > 700000 {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                        self.trayCardsFrames[1] = geo2.frame(in: .global)
                                                    }
                                                }

                                        }
                                        
                                    })
                            })
                            .zIndex(self.cardIsBeingMoved[1] ? 1.0 : 0.5)
                            .offset(x: self.serieNumbers == 0 ? self.xOffset : 0)
                            .offset(x: self.serieNumbers == 1 ? self.xOffset2 : 0)
                            .opacity(self.trayCardDropped[1] ? 0.0 : 1.0)
                        Spacer()
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 2, text: self.trayCard2)
                            .frame(width: geo.size.height/4.3 * 0.6
                                , height: geo.size.height/4.3)

                            .overlay(GeometryReader { geo2 in
                                Color.clear
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .onAppear{
                                                self.trayCardsFrames[2] = geo2.frame(in: .global)
                                        }
                                        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                            if self.screenDimension > 700000 {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                    self.trayCardsFrames[2] = geo2.frame(in: .global)
                                                }
                                            }

                                        }
                                    })
                            })
                            .zIndex(self.cardIsBeingMoved[2] ? 1.0 : 0.5)
                            .offset(x: self.serieNumbers == 0 ? self.xOffset : 0)
                            .offset(x: self.serieNumbers == 1 ? self.xOffset2 : 0)
                            .opacity(self.trayCardDropped[2] ? 0.0 : 1.0)
                        Spacer()
                    }
                   
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
                                        .padding(.top)
                                    Text("\(self.timeRemaining - self.vm.seconds)")
                                        .font(.subheadline)
                                        .fontWeight(.heavy)
                                        .padding(.top)
                                        .background(ColorReference.specialOrange)
                                        .font(.title)
                                        .onAppear{
                                            self.vm.setup(timeRemaining: 60)
                                        }

                                }
                                Text("Time left")
                                    .font(.footnote)
                            }
                            Spacer()
                            VStack {
                                Button(action: {
                                    self.showSheet = true
                                    self.activeSheet = .coinPurchase
                                }){
                                    Image("FinalCoin").renderingMode(.original)
                                        .resizable()
                                        .frame(width: geo.size.height/12
                                            , height: geo.size.height/12)
                                }
                                
                                Text("\(UserDefaults.standard.integer(forKey: "coins")) coins")
                                    .font(.footnote)
                            }
                            Spacer()
                            VStack{
                                Image("points2")
                                    .resizable()
                                    .frame(width: geo.size.height/12
                                        , height: geo.size.height/12)
                                Text("\(UserDefaults.standard.integer(forKey: "points")) points")
                                    .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension )
                                    .font(.footnote)
                                    .foregroundColor(.black)
                            }
                            Spacer()
                        }
                        
                    }
                }
                .blur(radius: self.secondLevelFinished || (self.timer0 || self.secondLevelWrong)  ?  75 : 0.0)
                    .zIndex(-0.5)
            }.onAppear{
                if achievement() {
                    self.activeSheet = .upLevel
                     self.showSheet = true
                }
    
                self.dismissView = UserDefaults.standard.bool(forKey: "dismissView")
                if self.dismissView {
                    self.presentationMode.wrappedValue.dismiss()
                }
                self.goQuizView = false
                self.secondLevelFinished = false
                self.timer0 = false
                self.secondLevelWrong = false
                self.serieNumbers = 0
                self.messageAfterAnswer = ""
                self.allCardsDropped = false
                self.percentComplete = 0.0
                self.quizStarted = false
                self.timeRemaining = 60
                for n in 0...2{
                    self.cardWasDropped[n] = false
                    self.trayCardDropped[n] = false
                    self.cardIsBeingMoved[n] = false
                    self.cardText[n] = ""
                }
                self.xOffset2 = 0
                self.xOffset = 0
                self.numberToFinish = 0
                self.upDateCardInfo(serieNumbers: self.serieNumbers)
            }
            .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                let screen = FontsAndConstraintsOptions()
                self.screenDimension = screen.screenSurface
                
            }
            .onReceive(self.vm.objectWillChange, perform: {
                if self.vm.time0 && !self.timer0 && self.vm.seconds == 60{
                    withAnimation(.linear(duration: 3.0)) {
                        self.timer0 = true
                    }
                    self.tryAgain = true
                    self.vm.cleanup()
                    self.cardAnimation()
                }
               
            })
        }
        .navigationBarTitle("What is the right order?", displayMode: .inline)
        .navigationBarHidden(secondLevelFinished)
        .background(ColorReference.specialGreen)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: self.$showSheet) {
            if self.activeSheet == .upLevel {
                LandMarkView()
            }else{
                CoinManagement()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    func cardDropped(location: CGPoint, trayIndex: Int, cardAnswer: String) {
        if let match = cardFrames.firstIndex(where: {
            $0.contains(location)
            
        }) {
            self.cardWasDropped[match] = true
            switch match {
            case 0:
                cardText[0] = trayCardText
                trayCardDates[0] = trayCardDate
                playSound(sound: "404015__paul-sinnett__card", type: "wav")
                if trayCardText == questionForSeries.seriesInfo[serieNumbers].rightPositionCard[0]{cardGood[0] = true}
            case 1:
                cardText[1] = trayCardText
                trayCardDates[1] = trayCardDate
                playSound(sound: "404015__paul-sinnett__card", type: "wav")
                if trayCardText == questionForSeries.seriesInfo[serieNumbers].rightPositionCard[1]{cardGood[1] = true}
            case 2:
                cardText[2] = trayCardText
                trayCardDates[2] = trayCardDate
                playSound(sound: "404015__paul-sinnett__card", type: "wav")
                if trayCardText == questionForSeries.seriesInfo[serieNumbers].rightPositionCard[2]{cardGood[2] = true}
            default:
                print("default2")
            }
            if cardText[0] != "" && cardText[1] != "" && cardText[2] != ""{
                allCardsDropped = true
            }
            
            if self.cardGood[0] && self.cardGood[1] && self.cardGood[2] && self.allCardsDropped{
                answerIsGood = true
                _ = addCoins(numberOfCoinsToAdd: 2)
                addPoints(numberOfPointsToAdd: 2)
                self.showSheet = achievement()
                activeSheet = .upLevel
            }else if self.allCardsDropped{
                answerIsGood = false
                self.vm.cleanup()
                withAnimation(.linear(duration: 3.0)) {
                    secondLevelWrong = !answerIsGood && allCardsDropped
                }
            }
            cardAnimation()
        }
    }
    func cardMoved(location: CGPoint, letter: String) -> DragState {
        if let match = cardFrames.firstIndex(where: {
            $0.contains(location)
        }) {
            if match == 0 || match == 1 || match == 2{
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
        if let match = trayCardsFrames.firstIndex(where: {
            $0.contains(location)
        }) {
            self.serieNumberDisplayed = true
            self.count = self.count + 1
            if self.count == 1 {cardIndex = match}
            if cardIndex == 0 {
                cardDescription = description0
                trayCardText = trayCard0
                trayCardDate = cardDate0
            }
            if cardIndex == 1 {
                cardDescription = description1
                trayCardText = trayCard1
                trayCardDate = cardDate1
            }
            if cardIndex == 2 {
                cardDescription = description2
                trayCardText = trayCard2
                trayCardDate = cardDate2
            }
            switch cardIndex {
            case 0:
                cardIsBeingMoved[0] = true
            case 1:
                cardIsBeingMoved[1] = true
            case 2:
                cardIsBeingMoved[2] = true
            default:
                print("default3")
            }
        }
        quizStarted = true
        tryAgain = false
        self.serieNumberDisplayed = false
        self.coins = UserDefaults.standard.integer(forKey: "coins")
        if coins < 0 {
            self.showSheet = true
        }
    }
    func cardUnpushed(location: CGPoint, trayIndex: Int) {
        if serieNumbers == 0 {
            cardDescription = "Serie 1 of 2"
        }else{
            cardDescription = "Serie 2 of 2"
        }
        for n in 0...2 {
            if cardText[n] == trayCard0 {self.trayCardDropped[0] = true }
            if cardText[n] == trayCard1 {self.trayCardDropped[1] = true }
            if cardText[n] == trayCard2 {self.trayCardDropped[2] = true }
            cardIsBeingMoved[n] = false
            self.count = 0
        }
        self.serieNumberDisplayed = true
        tryAgain = true
    }
    func cardAnimation () {
        if answerIsGood  && !self.vm.time0 {
            self.messageAfterAnswer = "Great!"
            playSound(sound: "chime_clickbell_octave_up", type: "mp3")
            withAnimation(Animation.linear(duration: 3.0).delay(2.0)) {
                self.xOffset = 1000
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.tryAgain = true
                if self.serieNumbers < 1 {self.serieNumbers = self.serieNumbers + 1}
                self.numberToFinish += 1
                self.answerIsGood = true
                for n in 0...2 {
                    self.percentComplete = 0
                    self.allCardsDropped = false
                    self.answerIsGood = false
                    self.cardWasDropped[n] = false
                    self.trayCardDropped[n] = false
                    self.cardGood[n] = false
                    self.cardText[n] = ""
                }
                if self.numberToFinish == 2 {
                    self.vm.cleanup()
                    _ = addCoins(numberOfCoinsToAdd: 5)
                    addPoints(numberOfPointsToAdd: 15)
                    playSound(sound: "music_harp_gliss_up", type: "wav")
                    withAnimation(.linear(duration: 3)){
                        self.secondLevelFinished  = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        self.goQuizView  = true
                        self.secondLevelFinished = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                        UserDefaults.standard.set(true, forKey: "dismissView")
                        self.dismissView = UserDefaults.standard.bool(forKey: "dismissView")
                    }
                }
                self.upDateCardInfo(serieNumbers: self.serieNumbers)
            }
        }else if self.vm.time0 || allCardsDropped{
            self.answerIsGood = false
            if !self.goQuizView{vm.setup(timeRemaining: 60)}
            serieNumbers = 0
            self.upDateCardInfo(serieNumbers: self.serieNumbers)
            self.cardDescription  = "Sorry...Try again!"
            playSound(sound: "Error Warning", type: "wav")
            switch numberToFinish {
            case 0:
                showSheet = removeCoins(numberOfCoinsToRemove: 2)
                activeSheet = .coinPurchase
            case 1:
                showSheet = removeCoins(numberOfCoinsToRemove: 2)
                activeSheet = .coinPurchase
            default:
                print("default7")
            }
        }
        withAnimation(.linear(duration: 6.0)) {
            self.xOffset2 = 0
        }
        tryAgain = true
    }
    func getFont(tryAgain: Bool) -> CGFloat {
        if tryAgain {
            return fonts.finalBigFont
        }else{
            return fonts.smallFontDimension
        }
    }
    func upDateCardInfo(serieNumbers: Int) {
        self.trayCard0 = self.questionForSeries.seriesInfo[serieNumbers].trayCardName[0]
        self.trayCard1 = self.questionForSeries.seriesInfo[serieNumbers].trayCardName[1]
        self.trayCard2 = self.questionForSeries.seriesInfo[serieNumbers].trayCardName[2]
        self.description0 = self.questionForSeries.seriesInfo[serieNumbers].cardDescription[0]
        self.description1 = self.questionForSeries.seriesInfo[serieNumbers].cardDescription[1]
        self.description2 = self.questionForSeries.seriesInfo[serieNumbers].cardDescription[2]
        self.cardDate0 = questionForSeries.seriesInfo[serieNumbers].cardDate[0]
        self.cardDate1 = questionForSeries.seriesInfo[serieNumbers].cardDate[1]
        self.cardDate2 = questionForSeries.seriesInfo[serieNumbers].cardDate[2]
    }
    
}

//struct TimeLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeLineView(item: NameItem.example, section: Names.example)
//    }
//}
