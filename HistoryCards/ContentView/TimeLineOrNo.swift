//
//  TimeLineOrNo.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-09-21.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct TimeLineOrNo: View {
    @EnvironmentObject var vm: ClockDetailViewModel
    @Binding var seeQuizData: Bool
    @Binding var startUp: Bool
    var body: some View {
        GeometryReader { geo in
            ZStack {
            VStack() {
                Text("See the Timeline before the Quiz?")
                    .padding()
                    .padding(.bottom)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.title)
                Button(action: {
                    self.seeQuizData = true
                    self.startUp = false
                }){
                    Text(" Yes, let's see ! ")
                        .font(.headline)
                        .padding()
                        .background(ColorReference.specialGreen)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                .padding()
                Button(action: {
                    self.seeQuizData = false
                    self.startUp = false
                    
                    self.vm.setup(timeRemaining: 90)
                }){
                    Text("No, I am ready!")
                        .font(.headline)
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
            }
            .frame(width: geo.size.width, height: geo.size.height * 0.9)
            
        }
       
        
    }
}

struct TimeLineOrNo_Previews: PreviewProvider {
    static var previews: some View {
        TimeLineOrNo(seeQuizData:Binding<Bool>.constant(false) , startUp: Binding<Bool>.constant(false))
    }
}
