//
//  QuizView.swift
//  HistoryQuizDevelopment5
//
//  Created by Normand Martin on 2020-03-01.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI
import GameKit
import UIKit

struct QuizView: View {
    let fonts = FontsAndConstraintsOptions()
    @State private var cardFrames = [CGRect](repeating: .zero, count: 4)
    @State private var trayCardsFrames = [CGRect](repeating: .zero, count: 4)
    @State private var cardGood = [false, false, false]
    @State private var trayCardDropped = [false, false, false]
    @State private var trayCardDate = ""
    @State private var cardWasDropped = [false, false, false]
    @State private var goQuizView = false
    @State private var cardText = ["", "", "", ""]
    @State private var allCardsDropped = false
    @State private var answerIsGood = false
    @State private var cardIsBeingMoved = [true, true, true]
    @State private var count = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var cardIndex = 0
    @State private var timeRemaining = 60
    @State private var quizStarted = false
    @State var quizData = QuizData()
    @State private var timer0 = false
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State private var points = UserDefaults.standard.integer(forKey: "points")
    @State private var thirdLevelIsWrong = false
    @State private var thirdLevelIsFinished = false
    @State private var showingQuizData = false
    @State private var dismissView = UserDefaults.standard.bool(forKey: "dismissView")
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var fontColorIsWhite = [true, true, true]
    @State private var cardSlotAnswered = [false, false, false]
    @State private var gradient = [Gradient(colors: [Color.clear, Color.clear]), Gradient(colors: [Color.clear, Color.clear]),  Gradient(colors: [Color.clear, Color.clear])]
    @State private var sectionIsDone = false
    @State private var sectionCount = Int()
    @State private var sectionDone = Int()
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .coinPurchase
    @State private var screenDimension: CGFloat = 0
    @EnvironmentObject private var vm: ClockDetailViewModel
    @State private var seconds: Int = 0
    var item: NameItem
    var section: Names
    @State var progressValue: Float = 0.5
    var body: some View {
        GeometryReader { geo in
            ZStack {
                        Image("fond")
                            .resizable()
                            .frame(width: geo.size.height/2.0, height: geo.size.height/1.2)
                            .cornerRadius(25)
                            .opacity(self.sectionIsDone ? 1.0 : 0.0)
                        VStack {
                            Text("Great!\nYou have mastered:")
                                .foregroundColor(.white)
                                .bold()
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .padding()
                            Text("\(self.section.name)")
                                .foregroundColor(ColorReference.specialOrange)
                                .italic()
                                .bold()
                            .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                .font(.headline)
                                .padding(.bottom)
                            Image(self.section.photo)
                                .resizable()
                                .frame(width: geo.size.height/12, height: geo.size.height/12)
                                .opacity(self.sectionIsDone ? 1.0 : 0.0)
                            .frame(width: geo.size.height/2.3, height: geo.size.height/10)
                            .padding(.top)
                            HStack {
                                Text("+30: ")
                                    .foregroundColor(.white)
                                    .padding()
                                VStack {
                                    Image("FinalCoin").renderingMode(.original)
                                        .resizable()
                                        .frame(width: geo.size.height/20
                                            , height: geo.size.height/20)
                                        .padding(.top)
                                        
                                   Text("\(UserDefaults.standard.integer(forKey: "coins")) coins")
                                        .frame(width: geo.size.width/4)
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                        
                                }
                            }
                            .padding()
        
                            HStack {
                                Text("+30: ")
                                    .foregroundColor(.white)
                                    .padding()
                                VStack{
                                    Image("points2")
                                        .resizable()
                                        .frame(width: geo.size.height/22
                                            , height: geo.size.height/22)
                                        
                                   Text("\(UserDefaults.standard.integer(forKey: "points")) points")
                                        .frame(width: geo.size.width/4)
                                        .font(.footnote)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()

                            Spacer()
                            HStack {
                                Button(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                    UserDefaults.standard.set(true, forKey: "dismissView")
                                }){
                                    Text("Back to menu")
                                        .font(.footnote)
                                        .padding()
                                        .background(Color.clear)
                                        .cornerRadius(40)
                                        .foregroundColor(.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(Color.white, lineWidth: 2)
                                    )
                                }
                                .padding()
                            }
                        }
                        .frame(width: geo.size.height/2.3, height: geo.size.height/1.4)
                        .opacity(self.sectionIsDone ? 1.0 : 0.0)
/////////////////////////////////////////////
                        Image("FinishedThirdLevel")
                            .resizable()
                            .frame(width: geo.size.height/2.5, height: geo.size.height/2.0)
                            .cornerRadius(25)
                            .opacity(self.thirdLevelIsFinished && !self.sectionIsDone ? 1.0 : 0.0)
                        VStack {
                            Text("You have completed:" )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .scaledFont(name: "Helvetica Neue", size: self.fonts.finalBigFont)
                                .padding()
                            Text("\(self.sectionDone)/\(self.sectionCount) of \(self.section.name): \(self.item.name ?? "")")
                                .foregroundColor(ColorReference.specialOrange)
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                                .padding(.leading)
                                .padding(.trailing)
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                UserDefaults.standard.set(true, forKey: "dismissView")
                                
                            }){
                                Text("Back to Menu")
                                    .font(.footnote)
                                    .padding()
                                    .background(Color.clear)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color.white, lineWidth: 2)
                                )
                            }
                            .padding()
                            Spacer()
                        }
                        .frame(width: geo.size.height/2.5, height: geo.size.height/2.0)
                        .opacity(self.thirdLevelIsFinished && !self.sectionIsDone ? 1.0 : 0.0)
/////////////////////////////////////////
                    Image(self.timer0 ? "TimesUp" : "Pouce bas")
                        .resizable()
                        .cornerRadius(25)
                        .opacity(self.timer0 || (self.thirdLevelIsWrong) ? 1.0 : 0)
                        .frame(width: geo.size.height/2.5, height: geo.size.height/2.0)
                    HStack {
                        VStack {
                            Spacer()
                            Text("Back to level 2")
                                .foregroundColor(.white)
                                .padding(.leading)
                            Button(action: {
                                UserDefaults.standard.set(false, forKey: "dismissView")
                                self.presentationMode.wrappedValue.dismiss()
                            }){
                                Image("0Coin").renderingMode(.original)
                                    .resizable()
                                    .frame(width: geo.size.height/12
                                        , height: geo.size.height/12)
                            }
                            Text("coin")
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            Text("Stay on level 3")
                                .foregroundColor(.white)
                                .padding(.trailing)
                            Button(action: {
                                self.quizData = QuizData()
                                self.vm.setup(timeRemaining: 60)
                                self.reset()
                                self.showSheet  = removeCoins(numberOfCoinsToRemove: 10)
                                self.activeSheet = .coinPurchase
                                
                            }){
                                Image("10Coin").renderingMode(.original)
                                    .resizable()
                                    .frame(width: geo.size.height/12
                                        , height: geo.size.height/12)
                                
                            }
                            Text("coins")
                                .foregroundColor(.white)
                                .padding(.bottom)
                        }
                    }
                    .frame(width: geo.size.height/2.5, height: geo.size.height/2.0)
                    .opacity(self.timer0 || (self.thirdLevelIsWrong) ? 1.0 : 0)
    ///////////////////////////////////////////
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Card(gradient: self.gradient[0] , onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed ,index: 0, text: self.cardText[0], fontColorIsWhite: self.fontColorIsWhite[0])
                            .frame(width: geo.size.height/4.3
                                * 0.6
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
                            .addBorder(self.cardWasDropped[0] ? Color.clear : Color.white, cornerRadius: 10)
                        Spacer()
                        Card(gradient: self.gradient[1], onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed ,index: 1, text: self.cardText[1], fontColorIsWhite: self.fontColorIsWhite[1])
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
                            .addBorder(self.cardWasDropped[1] ? Color.clear : Color.white, cornerRadius: 10)
                        
                        Spacer()
                        Card(gradient: self.gradient[2], onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed ,index: 2, text: self.cardText[2],  fontColorIsWhite: self.fontColorIsWhite[2])
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
                            .addBorder(self.cardWasDropped[2] ? Color.clear : Color.white, cornerRadius: 10)
                        Spacer()
                    }
                    .padding()
                    HStack {
                        Button(action: {
                            self.reset()
                            
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
                        }
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 0, text: self.quizData.dates[0])
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
                            .opacity(self.trayCardDropped[0] ? 0.0 : 1.0)
                        Spacer()
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 1, text: self.quizData.dates[1])
                            .frame(width: geo.size.height/4.3 * 0.6
                                , height: geo.size.height/4.3)
                            .overlay(GeometryReader { geo2 in
                                Color.clear
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .onAppear{
                                                self.trayCardsFrames[1] = geo2.frame(in: .global)
                                        }
                                        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                           if self.screenDimension > 700000 {
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                    self.trayCardsFrames[1] = geo2.frame(in: .global)
                                                }
                                            }

                                        }
                                    })
                            })
                            .zIndex(self.cardIsBeingMoved[1] ? 1.0 : 0.5)
                            .opacity(self.trayCardDropped[1] ? 0.0 : 1.0)
                        Spacer()
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 2, text: self.quizData.dates[2])
                            .frame(width: geo.size.height/4.3 * 0.6
                                , height: geo.size.height/4.3)
                            .overlay(GeometryReader { geo2 in
                                Color.clear
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .onAppear{
                                                self.trayCardsFrames[2] = geo2.frame(in: .global)
                                        }
                                        .onReceive(NotificationCenter.Publisher(center: .default, name:
                                            UIDevice.orientationDidChangeNotification)) { _ in
                                               if self.screenDimension > 700000 {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                        self.trayCardsFrames[2] = geo2.frame(in: .global)
                                            
                                                    }
                                                }

                                        }
                                    })
                            })
                            .zIndex(self.cardIsBeingMoved[2] ? 1.0 : 0.5)
                            .opacity(self.trayCardDropped[2] ? 0.0 : 1.0)
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    HStack {
                        ZStack(){
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
                                                self.timer0 = false
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
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                .blur(radius: self.thirdLevelIsFinished || (self.timer0 || self.thirdLevelIsWrong)  ?  75 : 0.0)
                .zIndex(-0.5)
            }
            .onAppear{
                self.progressValue = Float(Double(UserDefaults.standard.integer(forKey: "points"))/200.0)
                if self.progressValue > 1.0 {self.progressValue = 1.0}

            }
        }
        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
            let screen = FontsAndConstraintsOptions()
            self.screenDimension = screen.screenSurface
            
        }
        .onReceive(vm.objectWillChange, perform: {
            if self.vm.time0 && !self.timer0 {
                self.timer0 = true
                playSound(sound: "Error Warning", type: "wav")
            }
        })
        .background(ColorReference.specialGreen)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("What are the right dates?", displayMode: .inline)
        .navigationBarHidden(answerIsGood || (allCardsDropped && !answerIsGood) || timer0)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            self.showSheet = achievement()
            self.activeSheet = .upLevel
            self.cardText[0] = self.quizData.names[0]
            self.cardText[1] = self.quizData.names[1]
            self.cardText[2] = self.quizData.names[2]
        }
        .sheet(isPresented: self.$showSheet) {
            if self.activeSheet == .upLevel {
                LandMarkView()
            }else{
                CoinManagement()
            }
        }
    }
    func cardDropped(location: CGPoint, trayIndex: Int, cardAnswer: String) {
        if let match = cardFrames.firstIndex(where: {
            $0.contains(location)
        }) {
            self.cardWasDropped[match] = true
            playSound(sound: "404015__paul-sinnett__card", type: "wav")
            switch match {
            case 0:
                cardText[0] = trayCardDate
                cardSlotAnswered[0] = true
                self.fontColorIsWhite[0] = false
                self.gradient[0] = Gradient(colors: [ColorReference.specialOrange, ColorReference.specialGray])
                if trayCardDate == quizData.datesCards[0]{cardGood[0] = true}
            case 1:
                cardText[1] = trayCardDate
                cardSlotAnswered[1] = true
                self.fontColorIsWhite[1] = false
                self.gradient[1] = Gradient(colors: [ColorReference.specialOrange, ColorReference.specialGray])
                if trayCardDate == quizData.datesCards[1]{cardGood[1] = true}
            case 2:
                cardText[2] = trayCardDate
                self.fontColorIsWhite[2] = false
                cardSlotAnswered[2] = true
                self.gradient[2] = Gradient(colors: [ColorReference.specialOrange, ColorReference.specialGray])
                if trayCardDate == quizData.datesCards[2]{cardGood[2] = true}
            default:
                print("default4")
            }
            if cardSlotAnswered[0]  && cardSlotAnswered[1] && cardSlotAnswered[2]{
                allCardsDropped = true
            }
            if self.cardGood[0] && self.cardGood[1] && self.cardGood[2] {
                self.answerIsGood = true
                self.showSheet = achievement()
                self.activeSheet = .upLevel
                playSound(sound: "music_harp_gliss_up", type: "wav")
                _ = addCoins(numberOfCoinsToAdd: 20)
                addPoints(numberOfPointsToAdd: 20)
                if !isSectionDone() {
                    var accomplishement = Accomplishements()
                    accomplishement.quizCompletion(uuid: item.id.uuidString)
                    sectionIsDone = isSectionDone()
                    if sectionIsDone {
                        playSound(sound: "fanfare", type: "mp3")
                        _ = addCoins(numberOfCoinsToAdd: 10)
                        addPoints(numberOfPointsToAdd: 10)
                    }
                        
                }
                thirdLevelIsFinished = true
            }else if allCardsDropped == true {
                playSound(sound: "Error Warning", type: "wav")
                vm.setup(timeRemaining: 60)
                    self.thirdLevelIsWrong = true
            }
        }
    }
    func isSectionDone() -> Bool{
        let array = UserDefaults.standard.array(forKey: section.id.uuidString) as! [Bool]
        var testIfSectionIsDone = false
        sectionCount = array.count
        sectionDone = 0
        for section in array {
            if section {sectionDone += 1}
        }
        testIfSectionIsDone = array.allSatisfy({
            $0 == true
        })
        return testIfSectionIsDone
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
            return .unknown
        }
    }
    func cardPushed(location: CGPoint, trayIndex: Int){
        quizStarted = true
        if let match = trayCardsFrames.firstIndex(where: {
            $0.contains(location)
        }) {
            self.count = self.count + 1
            if self.count == 1 {cardIndex = match}
            trayCardDate = quizData.dates[cardIndex]
            switch cardIndex {
            case 0:
                cardIsBeingMoved[0] = true
            case 1:
                cardIsBeingMoved[1] = true
            case 2:
                cardIsBeingMoved[2] = true
            default:
                print("default5")
            }
        }
        self.coins = UserDefaults.standard.integer(forKey: "coins")
        if coins < 0 {
            self.showSheet = true
        }
        
    }
    func cardUnpushed(location: CGPoint, trayIndex: Int) {
        for n in 0...2 {
            if cardText[n] == quizData.dates[0]{self.trayCardDropped[0] = true }
            if cardText[n] == quizData.dates[1] {self.trayCardDropped[1] = true }
            if cardText[n] == quizData.dates[2] {self.trayCardDropped[2] = true }
            cardIsBeingMoved[n] = false
            self.count = 0
        }
    }
    func reset() {
        self.answerIsGood = false
        self.timer0 = false
        self.allCardsDropped = false
        self.thirdLevelIsFinished = false
        self.thirdLevelIsWrong = false
        self.quizStarted = false
        self.timeRemaining = 60
        self.gradient = [Gradient(colors: [Color.clear, Color.clear]), Gradient(colors: [Color.clear, Color.clear]),  Gradient(colors: [Color.clear, Color.clear])]
        for n in 0...2{
            self.cardWasDropped[n] = false
            self.cardGood[n] = false
            self.trayCardDropped[n] = false
            self.cardIsBeingMoved[n] = false
            self.cardText[n] = self.quizData.names[n]
            self.cardSlotAnswered[n] = false
            self.fontColorIsWhite[n] = true
            
        }
        
    }
    
    
}
//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//         
//        QuizView( item: NameItem.example, section: Names.example)
//    }
//}

