//
//  CoinManagement.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-05-13.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import SwiftUI
import StoreKit
import Combine

struct CoinManagement: View {
    @Environment(\.presentationMode) var presentationMode
    var iapManager = IAPManager()
    @State private var isNotConnectedNoReason = false
    @State private var showingAlertNoConnection = false
    @State private var showNoCoinsPurchased = false
    @State private var price = ""
    @ObservedObject var products = productsDB.shared
    @State private var stringCoin = String(UserDefaults.standard.integer(forKey: "coins"))
    @State private var showAlertPurchased = false
    @State private var coins = UserDefaults.standard.integer(forKey: "coins")
    var coinsPurchased = UserDefaults.standard.bool(forKey: "coinsPurchased")
    var sixHundredCoinsReached = UserDefaults.standard.bool(forKey: "sixHundredCoinsReached")
    let publisher = IAPManager.shared.purchasePublisher
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.coins =  UserDefaults.standard.integer(forKey: "coins")
                            if self.coins > 0 {
                                self.presentationMode.wrappedValue.dismiss()
                            }else{
                                self.showNoCoinsPurchased = true
                            }
                        }){
                            Text("Done")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .padding()
                    Text("Before you go on...")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.heavy)
                        .opacity(!self.coinsPurchased && self.sixHundredCoinsReached ? 1.0 : 0.0)
                    Text(!self.coinsPurchased && self.sixHundredCoinsReached ? "Do you think this App is worth \(self.price)?\nIf you do, please buy some coins" : "Out of coins?")
                        .foregroundColor(.white)
                        .font(!self.coinsPurchased && self.sixHundredCoinsReached ? .headline : .title)
                        .fontWeight(.heavy)
                        .padding()
                        .padding(.bottom)
                        .multilineTextAlignment(.center)
                    
                    HStack {
                        VStack {
                            Text("CREDIT AVAILABLE: \(self.stringCoin) coins")
                                .foregroundColor(ColorReference.specialOrange)
                                .font(.headline)
                                .fontWeight(.heavy)
                            Text("To preserve the visual integrity and user experience of the App. there are no adds in History Cards. ")
                                .font(.headline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .italic()
                                .padding()
                        }
                    }
                    .frame(width: geo.size.width/1.2, height: geo.size.height/5)
                    .addBorder(Color.white, cornerRadius: 0)
                    .padding(.bottom)
                    Spacer()
                    HStack{
                        Text("Do you enjoy History Cards?\nBuy  200 coins for \(self.price),\nit will last you forever!")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .font(.headline)
                    }
                    .padding(.top)
                    Spacer()
                    Button(action: {
                        if self.isNotConnectedNoReason {
                            self.showingAlertNoConnection = true
                        }else{
                            _ = IAPManager.shared.purchaseV5(product: self.products.items[0])
                        }
                    }){
                        Image("coin2").renderingMode(.original)
                            .resizable()
                            .frame(width: geo.size.height/7
                                , height: geo.size.height/7)
                    }
                    .padding(.bottom)
                    Spacer()
                }
            }
            .alert(isPresented: self.$showingAlertNoConnection) {
                Alert(title: Text("You are not connected to the internet"), message: Text("You cannot make a purchase"), dismissButton: .default(Text("OK")){
                    })
            }
            .alert(isPresented: self.$showAlertPurchased) {
                Alert(title: Text("200 coins were added to your credit"), message: Text("Back to the quiz!"), dismissButton: .default(Text("OK")){
                    UserDefaults.standard.set(true, forKey: "coinsPurchased")
                    })
            }
            .alert(isPresented: self.$showNoCoinsPurchased) {
                Alert(title: Text("Please Purchase Coins to continue"), message: Text("200 coins should last you for ever"), dismissButton: .default(Text("OK")){
                })
            }
            
            .onAppear{
                self.price = IAPManager.shared.getPriceFormatted(for: self.products.items[0]) ?? ""
                let reachability = Reachability()
                let isConnected = reachability.isConnectedToNetwork()
                IAPManager.shared.getProductsV5()
                self.isNotConnectedNoReason = false
                if !isConnected{
                    self.isNotConnectedNoReason = true
                    print("not connected")
                }
            }
        }
        .onReceive(publisher, perform: {value in
            self.stringCoin = value.0
            self.showAlertPurchased = true
        })
            .background(ColorReference.specialGreen)
            .edgesIgnoringSafeArea(.all)
    }
    
}

struct CoinManagement_Previews: PreviewProvider {
    static var previews: some View {
        CoinManagement()
    }
}

