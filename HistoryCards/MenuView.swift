//
//  ContentView.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-03-29.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    init() {
        // this is not the same as manipulating the proxy directly
        let appearance = UINavigationBarAppearance()
        // this overrides everything you have set up earlier.
        appearance.configureWithTransparentBackground()
        
        // this only applies to big titles
        //        appearance.largeTitleTextAttributes = [
        //            .font : UIFont.systemFont(ofSize: 20),
        //            NSAttributedString.Key.foregroundColor : UIColor.white
        //        ]
        // this only applies to small titles
        appearance.titleTextAttributes = [
            .font : UIFont.systemFont(ofSize: 29),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        //In the following two lines you make sure that you apply the style for good
        //  UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        // This property is not present on the UINavigationBarAppearance
        // object for some reason and you have to leave it til the end
        UINavigationBar.appearance().tintColor = .white
    }
    @State private var showContentView = false
    @ObservedObject var names = Names()
    var body: some View {
        NavigationView {
            List {
                ForEach(names.items) {item in
                    NavigationLink(destination: ContentView(item: item)){
                        Text(item.cardInfoName)
                    }
                }
            }
        }
        .navigationBarTitle("Choose a Time Line")
        .foregroundColor(.black)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: loadNames)
    }
    func loadNames() {
        let name1 = NameItem(cardInfoName: "Eras1", sequenceName: "SequenceEras1", quizName: "QuizEras1")
        names.items.append(name1)
        let name2 = NameItem(cardInfoName: "Eras2", sequenceName: "SequenceEras2", quizName: "QuizEras2")
        names.items.append(name2)
        print(names.items[0].cardInfoName)
        return
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
