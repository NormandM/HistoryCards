//
//  ContentView.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-03-29.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI
struct MenuView: View {
    
    let name = Bundle.main.decode([Names].self, from: "menu.json")
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State private var points = UserDefaults.standard.integer(forKey: "points")
    @State private var showContentView = false
    @State private var dismissView = false
    @State private var arrayDone = [[Bool]]()
    @State private var sectionIsDone = false
    @State private var turned = false
    var body: some View {
        VStack{
            List {
                ForEach (name) { section in
                    Section(header: SectionRow(name: section)) {
                        ForEach(section.items) {item in
                            NavigationLink(destination: ContentView(item: item, section: section)){
                                HStack {
                                    ItemRowView(item: item)
                                }
                                
                            }
                        }.listRowBackground(ColorReference.specialGreen)
                    }
                    
                }
                
            }
            .navigationBarTitle("Choose a Time Line" , displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                UserDefaults.standard.set(false, forKey: "dismissView")
                self.dismissView = UserDefaults.standard.bool(forKey: "dismissView")
            }
        }
        .onAppear{
            self.points = UserDefaults.standard.integer(forKey: "points")
            IAPManager.shared.getProductsV5()
            if !(self.userAlreadyExist(coins: "coins")){
                self.coins = 20
                self.points = 0
                UserDefaults.standard.set(self.coins, forKey: "coins")
                UserDefaults.standard.set(self.points, forKey: "points")
                UserDefaults.standard.set("Initital level", forKey: "level")
                UserDefaults.standard.set("1939-1940", forKey: "eventName")
                UserDefaults.standard.set("SequenceWW2-1", forKey: "sequenceName")
                UserDataInitialisation.initialValue()
            }
            AppStoreFeedBack.askForFeedback()
        }
        
    }
    func userAlreadyExist(coins: String) -> Bool {
        return UserDefaults.standard.object(forKey: coins) != nil
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
