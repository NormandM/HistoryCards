//
//  ItemRowView.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-04-10.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct ItemRowView: View {
    var item: NameItem
    @State var isDone = false
    var body: some View {
        ZStack {
            HStack {
                Text(item.name!)
                    .foregroundColor(.white)
                
                Image(systemName: "checkmark")
                    .foregroundColor(isDone ? .white : .clear)
                .padding()
            }
            
        }.background(ColorReference.specialGreen)
            .onAppear{
                print(self.isDone)
                print(self.item.id.uuidString)
                
                self.isDone = UserDefaults.standard.bool(forKey: self.item.id.uuidString)
        }
        
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: NameItem.example)
    }
}
