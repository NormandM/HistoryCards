//
//  HCLogoView.swift
//  
//
//  Created by Normand Martin on 2020-05-15.
//

import SwiftUI

struct HCLogoView: View {
    let fonts = FontsAndConstraintsOptions()
    var body: some View {
        GeometryReader { geo in
            VStack{
                Text("HISTORY")
                    .font(Font.custom("SF Distant Galaxy", size: self.fonts.titalFont))
                    .padding()
                Image("HCIcone")
                    .resizable()
                    .frame(width: geo.size.height/2.2, height: geo.size.height/2.2, alignment: .center)
                Text("CARDS")
                .font(Font.custom("SF Distant Galaxy", size: self.fonts.titalFont))
                .padding()
            }
        }
        .background(ColorReference.specialGray)
        .edgesIgnoringSafeArea(.all)

    }
}

struct HCLogoView_Previews: PreviewProvider {
    static var previews: some View {
        HCLogoView()
    }
}
