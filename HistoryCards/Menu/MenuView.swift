//
//  ContentView.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-03-29.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI
struct MenuView: View {
//    init() {
//        // this is not the same as manipulating the proxy directly
//        let appearance = UINavigationBarAppearance()
//        // this overrides everything you have set up earlier.
//        appearance.configureWithTransparentBackground()
//
//
//        // this only applies to big titles
//        //        appearance.largeTitleTextAttributes = [
//        //            .font : UIFont.systemFont(ofSize: 20),
//        //            NSAttributedString.Key.foregroundColor : UIColor.white
//        //        ]
//        // this only applies to small titles
//        appearance.titleTextAttributes = [
//            .font : UIFont.systemFont(ofSize: 29),
//            NSAttributedString.Key.foregroundColor : UIColor.white
//        ]
//        //In the following two lines you make sure that you apply the style for good
//        //  UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().standardAppearance = appearance
//        // This property is not present on the UINavigationBarAppearance
//        // object for some reason and you have to leave it til the end
//        UINavigationBar.appearance().tintColor = .white
//    }
    let name = Bundle.main.decode([Names].self, from: "menu.json")
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    @State private var points = UserDefaults.standard.integer(forKey: "points")
    @State private var showContentView = false
    @State private var dismissView = false
    var body: some View {

        NavigationView {
            VStack{
                    List {
                        ForEach (name) { section in
                            Section(header: SectionRow(name: section)) {
                                ForEach(section.items) {item in
                                     NavigationLink(destination: ContentView(item: item)){
                                        ItemRowView(item: item)
                                    }
                                }.listRowBackground(ColorReference.specialGreen)
                            }

                        }
                    
                }
                .navigationBarTitle("Choose a Time Line" , displayMode: .inline)
                .onAppear{
                    print("did appear")
                    UserDefaults.standard.set(false, forKey: "dismissView")
                    self.dismissView = UserDefaults.standard.bool(forKey: "dismissView")

                }
                
            }

        }
        
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            if !(self.userAlreadyExist(coins: "coins")){
                self.coins = 20
                self.points = 0
                UserDefaults.standard.set(self.coins, forKey: "coins")
                UserDefaults.standard.set(self.points, forKey: "points")
                UserDefaults.standard.set("WW2-1", forKey: "eventName")
                UserDefaults.standard.set("SequenceWW2-1", forKey: "sequenceName")
            }

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
