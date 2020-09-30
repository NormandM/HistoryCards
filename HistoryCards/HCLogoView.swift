//
//  HCLogoView.swift
//  
//
//  Created by Normand Martin on 2020-05-15.
//

import SwiftUI

struct HCLogoView: View {
    let fonts = FontsAndConstraintsOptions()
    @State private var nextViewPresent = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
            VStack{
                NavigationLink(destination: MenuView() , isActive: self.$nextViewPresent){
                    Text("")
                }
                Spacer()
                Text("HISTORY")
                    .font(.largeTitle)
                    .padding()
                Image("HCIcone")
                    .resizable()
                    .frame(width: geo.size.height/2.2, height: geo.size.height/2.2, alignment: .center)
                Text("CARDS")
                .font(.largeTitle)
                .padding()
                Spacer()
            }
            .background(ColorReference.specialGray)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.nextViewPresent = true
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        



        }
        .background(ColorReference.specialGray)
        .edgesIgnoringSafeArea(.all)
        
    }
}

//struct HCLogoView_Previews: PreviewProvider {
//    static var previews: some View {
//        HCLogoView()
//    }
//}
