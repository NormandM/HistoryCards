//
//  NMLogo.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-13.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct NMLogo:  View {
    @State private var xOffset: CGFloat = 300
    @State private var nextViewPresent = false
    var body: some View {
        
        NavigationView {
            GeometryReader { geo in
                VStack{
                    NavigationLink(destination: HCLogoView() , isActive: self.$nextViewPresent){
                        Text("")
                    }
                    Spacer()
                    Image("Normand martin Logo")
                        .resizable()
                        .frame(width: geo.size.height/2.3, height: geo.size.height/2.3)
                    Text("Apps")
                        .font(.title)
                        .offset(x: self.xOffset)
                    Spacer()
                    Spacer()
                    
                }
            }
            .onAppear{
                withAnimation(Animation.easeInOut(duration: 2.0).delay(1.0)) {
                    self.xOffset = 0
                }
                playSound(sound: "Acoustic Trio", type: "wav")
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.nextViewPresent = true
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

struct NMLogo_Previews: PreviewProvider {
    static var previews: some View {
        NMLogo()
    }
}
