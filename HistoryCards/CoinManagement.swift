//
//  CoinManagement.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-13.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI

struct CoinManagement: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }){
                            Text("Done")
                                .font(.footnote)
                                .foregroundColor(.white)
                            .padding()
                        }
                    }
                    .padding()
                    Text("Manage your Credits")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.heavy)
                        .padding(.bottom)
                        .padding(.bottom)
                    HStack {
                        VStack {
                            Text("CREDIT AVAILABLE: \(UserDefaults.standard.integer(forKey: "coins")) coins")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            
                            Text("To preserve the visual integrity and user experience of the App. there are no adds in History Cards. ")
                                .font(.callout)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .italic()
                                .padding()
                        }
                        
                        
                    }
                    .frame(width: geo.size.width/1.2, height: geo.size.height/5)
                    .addBorder(Color.white, cornerRadius: 0)
                    .padding(.bottom)
                    HStack{
                        Text("Do you enjoy History Cards?\nBuy  200 coins for $1.00,\nit will last you forever")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .font(.callout)
                        
                    }
                    .padding(.top)
                    Button(action: {
                        print()
                    }){
                        Image("coin2").renderingMode(.original)
                            .resizable()
                            .frame(width: geo.size.height/7
                                , height: geo.size.height/7)
                        
                    }
                    .padding(.bottom)
                    Spacer()
//                    Button(action: {
//                        print()
//
//                    }){
//                        Text("OK")
//                            .font(.footnote)
//                            .padding()
//                            .padding()
//                            .background(ColorReference.specialGreen)
//                            .cornerRadius(100)
//                            .foregroundColor(.white)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 100)
//                                    .stroke(Color.white, lineWidth: 2)
//                        )
//
//                    }
                    
                    
                    
                }
            }
        }
        .background(ColorReference.specialGreen)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CoinManagement_Previews: PreviewProvider {
    static var previews: some View {
        CoinManagement()
    }
}
