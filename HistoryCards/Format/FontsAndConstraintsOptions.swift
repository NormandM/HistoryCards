//
//  FontsAndConstraintsOptions.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-12-10.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import SwiftUI
struct FontsAndConstraintsOptions {
    let screenDeviceDimension: ScreenDimension
    let multiplierConstraint: CGFloat
    let fontDimension: CGFloat
    let smallFontDimension: CGFloat
    let screenSurface: CGFloat
    let finalBigFont: CGFloat
    let titalFont: CGFloat
    init() {
        let screenSize = UIScreen.main.bounds
        let surfaceScreen = screenSize.width * screenSize.height
        var multiplier = CGFloat()
        var screenType = ScreenDimension.iPhone5
        var localFont: CGFloat = 0
        var bigFont:CGFloat = 0
        var titalFonts: CGFloat = 0
        var smallLocalFont: CGFloat = 0
        if surfaceScreen < 200000 {
            smallLocalFont = 10
            localFont = 10
            bigFont = 12
            titalFonts = 30
            multiplier = 0.52
        }else if surfaceScreen > 200000 && surfaceScreen < 304600 {
            screenType = .iPhone6
             smallLocalFont = 12
            localFont = 11
            bigFont = 14
            titalFonts = 32
            multiplier = 0.55
        }else if surfaceScreen > 304600 && surfaceScreen < 350000 {
            screenType = .iPhone8Plus
            smallLocalFont = 12
            localFont = 14
            bigFont = 16
            titalFonts = 34
             multiplier = 0.55
        }else if surfaceScreen > 350000 && surfaceScreen < 700000 {
            smallLocalFont = 11
            localFont = 16
            bigFont = 15
            titalFonts = 36
            screenType = .iPhoneX
        }else if surfaceScreen > 700000 && surfaceScreen < 800000{
            smallLocalFont = 12
            localFont = 14
            bigFont = 16
            titalFonts = 38
            screenType = .iPad9
            multiplier = 0.6
        }else if surfaceScreen > 800000 && surfaceScreen < 1000000{
            smallLocalFont = 16
            localFont = 16
            bigFont = 20
            titalFonts = 40
            multiplier = 0.6
        }else if surfaceScreen > 1000000{
            smallLocalFont = 18
            localFont = 26
            bigFont = 22
            titalFonts = 45
            screenType = .iPad12
            multiplier = 0.6
        }
        finalBigFont = bigFont
        smallFontDimension = smallLocalFont
        fontDimension = localFont
        screenDeviceDimension = screenType
        multiplierConstraint = multiplier
        titalFont = titalFonts
        screenSurface = surfaceScreen
    }
}
extension FontsAndConstraintsOptions {
    func device() -> ScreenDimension.RawValue {
        let screenSize = UIScreen.main.bounds
        let surfaceScreen = screenSize.width * screenSize.height
        var deviceType = String ()
        if surfaceScreen < 200000 {            deviceType = ScreenDimension.iPhone5.rawValue
        }else if surfaceScreen > 200000 && surfaceScreen < 304600 {
            deviceType = ScreenDimension.iPhone6.rawValue
        }
        return deviceType
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

