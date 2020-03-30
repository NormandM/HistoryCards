//
//  QUizDataView.swift
//  HistoryQuizDevelopment5
//
//  Created by Normand Martin on 2020-03-28.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct QUizDataView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var eventData: [EventAndSection] = AllEvents.event

    var body: some View {
        //ZStack {
            NavigationView{
                List{
                    ForEach(eventData){section in
                        Section(header: Text(section.date)){
                            ForEach(section.items){item in
                                Text(item.name)
                                
                                Text(item.description)
                            }
                            //.listRowBackground(ColorReference.specialGreen)
                        }
                    }
                }
                .navigationBarItems(trailing:
                Button(action: {
                   self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                    .foregroundColor(.black)
                })
                .navigationBarTitle("Great Inventions")
            }
        }
  //  }

}
struct QUizDataView_Previews: PreviewProvider {
    static var previews: some View {
        QUizDataView()
    }
}
