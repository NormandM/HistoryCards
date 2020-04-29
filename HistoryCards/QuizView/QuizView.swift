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
    @State private var trayCardDate = ""
    @State private var cardWasDropped = [false, false, false]
    @State private var goQuizView = false
    @State private var cardText = ["", "", "", ""]
    @State private var allCardsDropped = false
    @State private var answerIsGood = false
    @State private var cardIsBeingMoved = [true, true, true]
    @State private var count = 0
    private let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var cardIndex = 0
    @State private var timeRemaining = 120
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
    var item: NameItem
    var section: Names
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if self.answerIsGood  && !self.timer0{
                    if self.sectionIsDone{
                        Image("fond")
                            .resizable()
                            .frame(width: geo.size.height/2.5, height: geo.size.height/1.5)
                            .cornerRadius(25)
                            .opacity(self.sectionIsDone ? 1.0 : 0.0)
                        
                        VStack {
                            Text("Great!\nYou have mastered:")
                                .foregroundColor(.white)
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.title)
                                .padding()
                            Text("\(self.section.name)")
                                .foregroundColor(ColorReference.specialOrange)
                                .italic()
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.largeTitle)
                            Image(self.section.photo)
                                .resizable()
                                .frame(width: geo.size.height/12, height: geo.size.height/12)
                                .opacity(self.sectionIsDone ? 1.0 : 0.0)
                                .padding()
                            Spacer()
                            HStack {
                                 Text("100 coins was added:")
                                     .foregroundColor(.white)
                                     .bold()
                                    .font(.body)
                                     .padding()
                                 VStack {
                                     Image("GreenCoin")
                                         .resizable()
                                         .frame(width: geo.size.height/18
                                             , height: geo.size.height/18)
                                     Text("\(UserDefaults.standard.integer(forKey: "coins"))")
                                        .font(.footnote)
                                         .foregroundColor(.white)
                                 }
                             .padding()
                             }
                            Spacer()
                            HStack {
                                Text("100 points was added:")
                                    .foregroundColor(.white)
                                    .bold()
                                    .font(.body)
                                    .padding()
                                VStack {
                                    Image("points2")
                                        .resizable()
                                        .frame(width: geo.size.height/19
                                            , height: geo.size.height/19)
                                    Text("\(UserDefaults.standard.integer(forKey: "points"))")
                                        .scaledFont(name: "Helvetica Neue", size: self.fonts.smallFontDimension )
                                        .foregroundColor(.white)
                                    
                                    
                                }
                                .padding()
                            }
                            Spacer()
                            HStack {
                                Button(action: {
                                    
                                }){
                                    Text("Leader Board")
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
                            
                        }.frame(width: geo.size.height/2.5, height: geo.size.height/1.5)
                        
                        
                    }else{
                        Image("FinishedThirdLevel")
                            .resizable()
                            .frame(width: geo.size.height/2.5, height: geo.size.height/2.0)
                            .cornerRadius(25)
                            .opacity(self.thirdLevelIsFinished && !self.sectionIsDone ? 1.0 : 0.0)
                        VStack {
                            Text("You have completed:\n\(self.item.name!)" )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .scaledFont(name: "Helvetica Neue", size: self.fonts.finalBigFont)
                                .padding()
                            Text("\(self.sectionDone)/\(self.sectionCount) of \(self.section.name)")
                                .foregroundColor(ColorReference.specialOrange)
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
                            .padding()
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
                            Spacer()

                        
                        }
                        .frame(width: geo.size.height/2.5, height: geo.size.height/2.0)
                        
                        
                    }
                }else if self.timer0 || (self.allCardsDropped && !self.answerIsGood){
                    Image("Pouce bas")
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
                                self.reset()
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
                                .padding(.bottom)
                        }
                    }
                    .frame(width: geo.size.height/2.5, height: geo.size.height/2.0)
                }
                
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
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                self.cardFrames[0] = geo2.frame(in: .global)
                                            }
                                        }
                                    })
                            })
                            .addBorder(Color.white, cornerRadius: 10)
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
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                self.cardFrames[1] = geo2.frame(in: .global)
                                            }
                                        }
                                        
                                    })
                            })
                            .addBorder(Color.white, cornerRadius: 10)
                        
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
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                self.cardFrames[2] = geo2.frame(in: .global)
                                            }
                                        }
                                    })
                            })
                            .addBorder(Color.white, cornerRadius: 10)
                        Spacer()
                    }
                    .padding()
                    HStack {
                        Button(action: {
                            self.reset()
                            
                        }){
                            Text("Start Over")
                             //   .scaledFont(name: "Helvetica Neue", size: self.fonts.fontDimension)
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
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                self.trayCardsFrames[0] = geo2.frame(in: .global)
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
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                self.trayCardsFrames[1] = geo2.frame(in: .global)
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
                                        
                                        Text("\(self.timeRemaining)")
                                            .onReceive(self.timer2) { _ in
                                                if self.timeRemaining  > 0 && self.quizStarted {
                                                    self.timeRemaining -= 1
                                                }else if self.timeRemaining  == 0 && self.quizStarted {
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
                                        print()
                                    }){
                                        Image("FinalCoin").renderingMode(.original)
                                            .resizable()
                                            .frame(width: geo.size.height/12
                                                , height: geo.size.height/12)
                                    }
                                    
                                    Text("\(self.coins) coins")
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
        }
        .background(ColorReference.specialGreen)
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("What are the right dates?", displayMode: .inline)
        .navigationBarHidden(answerIsGood || (allCardsDropped && !answerIsGood) || timer0)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            self.cardText[0] = self.quizData.names[0]
            self.cardText[1] = self.quizData.names[1]
            self.cardText[2] = self.quizData.names[2]
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
                print()
            }
            if cardSlotAnswered[0]  && cardSlotAnswered[1] && cardSlotAnswered[2]{
                allCardsDropped = true
            }
            if self.cardGood[0] && self.cardGood[1] && self.cardGood[2] {
                self.answerIsGood = true
                withAnimation (.linear(duration: 2)){
                    thirdLevelIsFinished = true
                    playSound(sound: "music_harp_gliss_up", type: "wav")
                    self.points = UserDefaults.standard.integer(forKey: "points")
                    self.points += 10
                    UserDefaults.standard.set(self.points, forKey: "points")
                    var accomplishement = Accomplishements()
                    accomplishement.quizCompletion(uuid: item.id.uuidString)
                    print(item.id.uuidString)
                    print(section.name)
                    print(section.id.uuidString)
                    let array = UserDefaults.standard.array(forKey: section.id.uuidString) as! [Bool]
                    sectionCount = array.count
                    sectionDone = 0
                    for section in array {
                        if section {sectionDone += 1}
                    }
                    
                    sectionIsDone = array.allSatisfy({
                        $0 == true
                    })
                    print("sectionIsDone: \(sectionIsDone)")
                }
            }else if allCardsDropped == true {
                withAnimation (.linear(duration: 2)){
                    self.thirdLevelIsWrong = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                UserDefaults.standard.set(true, forKey: "dismissView")
                self.dismissView = UserDefaults.standard.bool(forKey: "dismissView")
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
            trayCardDate = quizData.dates[cardIndex]
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
        self.timeRemaining = 120
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
struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
         
        QuizView( item: NameItem.example, section: Names.example)
    }
}

