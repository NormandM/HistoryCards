//
//  QuizView.swift
//  HistoryQuizDevelopment5
//
//  Created by Normand Martin on 2020-03-01.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct QuizView: View {
    let fonts = FontsAndConstraintsOptions()
    @State private var cardFrames = [CGRect](repeating: .zero, count: 4)
    @State private var trayCardsFrames = [CGRect](repeating: .zero, count: 4)
    @State private var cardGood = [false, false, false]
    @State private var trayCardDropped = [false, false, false]
    @State private var trayCardText = ""
    @State private var cardWasDropped = [false, false, false]
    @State private var goQuizView = false
    @State private var cardText = ["", "", "", "", ""]
    @State private var allCardsDropped = false
    @State private var answerIsGood = false
    @State private var cardIsBeingMoved = [true, true, true]
    @State private var count = 0
    private let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var cardIndex = 0
    @State private var timeRemaining = 120
    @State private var quizStarted = false
    @State private var quizData = QuizData()
    @State private var timer0 = false
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State private var points = UserDefaults.standard.integer(forKey: "points")
    @State private var thirdLevelIsWrong = false
    @State private var thirdLevelIsFinished = false
    @State private var showingQuizData = false
    @State private var dismissView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
            GeometryReader { geo in
                ZStack {
                    NavigationLink(destination: QuizView(), isActive: self.$goQuizView){
                        Text("")
                    }
                    if self.answerIsGood  && !self.timer0{
                        Image("MasterOfInventions")
                            .resizable()
                            .frame(width: geo.size.height/2.5, height: geo.size.height/2.5)
                            .cornerRadius(25)
                            .opacity(self.thirdLevelIsFinished ? 1.0 : 0.0)
                        VStack {
                            Button(action: {
                                self.showingQuizData.toggle()
                                
                            }){
                                Text("See quiz Data")
                                    .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension)
                                    .padding()
                                    .background(Color.clear)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color.white, lineWidth: 2)
                                )
                            }
                            .sheet(isPresented: self.$showingQuizData) {
                                QUizDataView()
                            }
                            Divider()
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                                
                            }){
                                Text("Back to Menu")
                                    .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension)
                                    .padding()
                                    .background(Color.clear)
                                    .cornerRadius(40)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color.white, lineWidth: 2)
                                )
                            }
                        }
                            
                    }else if self.timer0 || (self.allCardsDropped && !self.answerIsGood){
                        Image("Pouce bas")
                            .resizable()
                            .cornerRadius(25)
                            .opacity(self.timer0 || (self.thirdLevelIsWrong) ? 1.0 : 0)
                            .frame(width: geo.size.height/2.5, height: geo.size.height/2.5)
                        HStack {
                            VStack {
                                Text("Back to level 1")
                                    .foregroundColor(.white)
                                Button(action: {
                                  self.presentationMode.wrappedValue.dismiss()
                                self.presentationMode.wrappedValue.dismiss()
                                }){
                                    Image("0Coin").renderingMode(.original)
                                        .resizable()
                                        .frame(width: geo.size.height/12
                                            , height: geo.size.height/12)
                                }
                                Text("10coins")
                                    .foregroundColor(.white)
                            }
                            .offset(x: -geo.size.height/16, y: geo.size.height/9)
                            
                            VStack {
                                Text("Stay on level 3")
                                    .foregroundColor(.white)
                                Button(action: {
                                    self.quizData = QuizData()
                                    self.answerIsGood = false
                                    self.timer0 = false
                                    self.allCardsDropped = false
                                    self.thirdLevelIsFinished = false
                                    self.thirdLevelIsWrong = false
                                    self.quizStarted = false
                                    self.timeRemaining = 120
                                    for n in 0...2{
                                        self.cardWasDropped[n] = false
                                        self.cardGood[n] = false
                                        self.trayCardDropped[n] = false
                                        self.cardIsBeingMoved[n] = false
                                        self.cardText[n] = ""
                                    }
                                    self.coins -= 10
                                    UserDefaults.standard.set(self.coins, forKey: "coins")
                                    
                                }){
                                    Image("10Coin").renderingMode(.original)
                                        .resizable()
                                        .frame(width: geo.size.height/12
                                            , height: geo.size.height/12)
                                    
                                }
                                Text("coins")
                                    .foregroundColor(.white)
                            }
                            .offset(x: geo.size.height/16 , y: geo.size.height/9)
                        }
                    }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(self.quizData.questions[0])
                            .frame(width: geo.size.width/1.5, height: geo.size.height/15, alignment: .leading)
                            .foregroundColor(.white)

                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed ,index: 0, text: self.cardText[0])
                            .frame(width: geo.size.height/7
                                * 0.6
                                , height: geo.size.height/7)
                            .allowsHitTesting(false)
                            .overlay(GeometryReader { geo2 in
                                Color.clear
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .onAppear{
                                                self.cardFrames[0] = geo2.frame(in: .global)
                                        }
                                        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                               self.cardFrames[0] = geo2.frame(in: .global)
                                            }
                                        }
                                    })
                            })
                            .opacity(self.cardWasDropped[0] ? 1.0 : 0.0)
                            .addBorder(Color.white, cornerRadius: 10)
                        Spacer()
                    }
                    .padding()
    
                    HStack {
                        Spacer()
                        Text(self.quizData.questions[1])
                            .frame(width: geo.size.width/1.5, height: geo.size.height/15, alignment: .leading)
                            .foregroundColor(.white)
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed ,index: 1, text: self.cardText[1])
                            .frame(width: geo.size.height/7 * 0.6
                                , height: geo.size.height/7)
                            .allowsHitTesting(false)
                            .overlay(GeometryReader { geo2 in
                                Color.clear
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .onAppear{
                                                self.cardFrames[1] = geo2.frame(in: .global)
                                                if self.dismissView {
                                                    self.presentationMode.wrappedValue.dismiss()
                                                }

                                        }
                                        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                               self.cardFrames[1] = geo2.frame(in: .global)
                                            }
                                        }
                                
                                    })
                            })
                            .opacity(self.cardWasDropped[1] ? 1.0 : 0.0)
                            .addBorder(Color.white, cornerRadius: 10)
    
                        Spacer()
                    }
                    .padding()
                    HStack {
                        Spacer()
                        Text(self.quizData.questions[2])
                            .frame(width: geo.size.width/1.5, height: geo.size.height/15, alignment: .leading)
                            .foregroundColor(.white)
                        Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed ,index: 2, text: self.cardText[2])
                            .frame(width: geo.size.height/7 * 0.6
                                , height: geo.size.height/7)
                            .allowsHitTesting(false)
                            .overlay(GeometryReader { geo2 in
                                Color.clear
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .onAppear{
                                                self.cardFrames[2] = geo2.frame(in: .global)
                                        }
                                        .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                               self.cardFrames[2] = geo2.frame(in: .global)
                                            }
                                        }
                                    })
                            })
                            .opacity(self.cardWasDropped[2] ? 1.0 : 0.0)
                            .addBorder(Color.white, cornerRadius: 10)
                        Spacer()
                        
                    }
                    .padding()
                
                    VStack {

                        HStack {
                             Spacer()
                                Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 0, text: self.quizData.answers[0])
                                    .frame(width: geo.size.height/7 * 0.6
                                        , height: geo.size.height/7)
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .overlay(GeometryReader { geo2 in
                                                Color.clear
                                                    .onAppear{
                                                        self.trayCardsFrames[0] = geo2.frame(in: .global)
                                                }
                                                .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                       self.trayCardsFrames[0] = geo2.frame(in: .global)
                                                    }
                                                }
                                                
                                            })
                                    })
                                    .zIndex(self.cardIsBeingMoved[0] ? 1.0 : 0.5)
                                    .opacity(self.trayCardDropped[0] ? 0.0 : 1.0)
                                     Spacer()
                                Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 1, text: self.quizData.answers[1])
                                    .frame(width: geo.size.height/7 * 0.6
                                        , height: geo.size.height/7)
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .overlay(GeometryReader { geo2 in
                                                Color.clear
                                                    .onAppear{
                                                        self.trayCardsFrames[1] = geo2.frame(in: .global)
                                                }
                                                .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                       self.trayCardsFrames[1] = geo2.frame(in: .global)
                                                    }
                                                }
                                            })
                                    })
                                    .zIndex(self.cardIsBeingMoved[1] ? 1.0 : 0.5)
                                    .opacity(self.trayCardDropped[1] ? 0.0 : 1.0)
                                     Spacer()
                                Card(onChanged: self.cardMoved, onEnded: self.cardDropped,onChangedP: self.cardPushed, onEndedP: self.cardUnpushed, index: 2, text: self.quizData.answers[2])
                                    .frame(width: geo.size.height/7 * 0.6
                                        , height: geo.size.height/7)
                                    .overlay(GeometryReader { geo2 in
                                        Color.clear
                                            .overlay(GeometryReader { geo2 in
                                                Color.clear
                                                    .onAppear{
                                                        self.trayCardsFrames[2] = geo2.frame(in: .global)
                                                }
                                                .onReceive(NotificationCenter.Publisher(center: .default, name: UIDevice.orientationDidChangeNotification)) { _ in
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                       self.trayCardsFrames[2] = geo2.frame(in: .global)
                                                    }
                                                }
                                            })
                                    })
                                    .zIndex(self.cardIsBeingMoved[2] ? 1.0 : 0.5)
                                    .opacity(self.trayCardDropped[2] ? 0.0 : 1.0)
                                    Spacer()
                        }
                        .padding()
                
    
                        
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
                                        
                                        Text("\(self.timeRemaining)")
                                            .onReceive(self.timer2) { _ in
                                                if self.timeRemaining  > 0 && self.quizStarted {
                                                    self.timeRemaining -= 1
                                                }else if self.timeRemaining  == 0 && self.quizStarted {
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
                        
                    }
                }
                .blur(radius: self.thirdLevelIsFinished || (self.timer0 || self.thirdLevelIsWrong)  ?  75 : 0.0)
                .zIndex(-0.5)
                }
            }
            .background(ColorReference.specialGreen)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("What are the right dates?", displayMode: .inline)
            .navigationBarHidden(answerIsGood || (allCardsDropped && !answerIsGood) || timer0)
            .navigationBarBackButtonHidden(true)
    }
    
    func cardDropped(location: CGPoint, trayIndex: Int, cardAnswer: String) {
            if let match = cardFrames.firstIndex(where: {
                $0.contains(location)
            }) {
                self.cardWasDropped[match] = true
                playSound(sound: "404015__paul-sinnett__card", type: "wav")
                switch match {
                case 0:
                    cardText[0] = trayCardText
                    if trayCardText == quizData.answers[0]{cardGood[0] = true}
                case 1:
                    cardText[1] = trayCardText
                    if trayCardText == quizData.answers[1]{cardGood[1] = true}
                case 2:
                    cardText[2] = trayCardText
                    if trayCardText == quizData.answers[2]{cardGood[2] = true}
                default:
                    print()
                }
                if cardText[0] != "" && cardText[1] != "" && cardText[2] != ""{
                    allCardsDropped = true
                }
                if self.cardGood[0] && self.cardGood[1] && self.cardGood[2] {
                    print("isGood")
                    self.answerIsGood = true
                    withAnimation (.linear(duration: 2)){
                        thirdLevelIsFinished = true
                    }
                }else if allCardsDropped == true {
                    withAnimation (.linear(duration: 2)){
                        self.thirdLevelIsWrong = true
                    }
                    self.points = UserDefaults.standard.integer(forKey: "points")
                    self.points += 10
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.dismissView = true
                }
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
                return .unknown
            }
        }
        func cardPushed(location: CGPoint, trayIndex: Int){
            
            if let match = trayCardsFrames.firstIndex(where: {
                $0.contains(location)
            }) {
                self.count = self.count + 1
                if self.count == 1 {cardIndex = match}
                trayCardText = quizData.answers[cardIndex]
                switch cardIndex {
                case 0:
                    cardIsBeingMoved[0] = true
                case 1:
                    cardIsBeingMoved[1] = true
                case 2:
                    cardIsBeingMoved[2] = true
                default:
                    print()
                }
            }
            
        }
        func cardUnpushed(location: CGPoint, trayIndex: Int) {
            for n in 0...2 {
                if cardText[n] == quizData.answers[0]{self.trayCardDropped[0] = true }
                if cardText[n] == quizData.answers[1] {self.trayCardDropped[1] = true }
                if cardText[n] == quizData.answers[2] {self.trayCardDropped[2] = true }
                cardIsBeingMoved[n] = false
                self.count = 0
                
            }
        }
    

}
struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}

