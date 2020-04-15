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
    var body: some View {
        ZStack {
            Text(item.name)
                .foregroundColor(.white)
        }.background(ColorReference.specialGreen)
        
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: NameItem.example)
    }
}
