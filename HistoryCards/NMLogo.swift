//
//  NMLogo.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-13.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct NMLogo: View {
    @State private var xOffset: CGFloat = 300
    var body: some View {
        GeometryReader { geo in
            VStack{
                Image("Normand martin Logo")
                    .resizable()
                    .frame(width: geo.size.height/2.3, height: geo.size.height/2.3)
                Text("Apps")
                    .font(.title)
                    .offset(x: self.xOffset)
                
            }
        }
        .onAppear{
            withAnimation(Animation.easeInOut(duration: 2.0).delay(1.0)) {
                self.xOffset = 0
            }
            playSound(sound: "Acoustic Trio", type: "wav")
        }
        
        
        
    }
}

struct NMLogo_Previews: PreviewProvider {
    static var previews: some View {
        NMLogo()
    }
}
