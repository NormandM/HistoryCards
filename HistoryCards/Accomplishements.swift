//
//  Accomplishements.swift
//  HistoryCards
//
//  Created by Normand Martin on 2020-04-17.
//  Copyright © 2020 Normand Martin. All rights reserved.
//

import Foundation
struct Accomplishements {
    var eras = UserDefaults.standard.array(forKey: "EF1CC5BB-4785-4D8E-AB98-5FA4E00B6A66") as! [Bool]
    var ancientCivilisations = UserDefaults.standard.array(forKey: "3D97FAB4-50AC-40FC-9BF0-3F46BB6A92F5") as! [Bool]
    var revolutions = UserDefaults.standard.array(forKey: "1C89DAFD-7653-4EF2-BF20-C51A159BAC43") as! [Bool]
    var americainRevolution = UserDefaults.standard.array(forKey: "CE3C67F9-79E3-46E3-B134-362A52ABFE3C") as! [Bool]
    var frenchRevolution = UserDefaults.standard.array(forKey: "72A67ED4-7CF8-11EA-BC55-0242AC130003") as! [Bool]
    var wars = UserDefaults.standard.array(forKey: "6F2D0E08-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    var napoleon = UserDefaults.standard.array(forKey: "DF3685AA-7D9B-11EA-BC55-0242AC130003") as! [Bool]
    var americainCivilWar = UserDefaults.standard.array(forKey: "6F2D14E8-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    var ww1 = UserDefaults.standard.array(forKey: "6F2D192A-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    var ww2 = UserDefaults.standard.array(forKey: "6F2D1B82-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    var space = UserDefaults.standard.array(forKey: "6F2D1EAC-7B4A-11EA-BC55-0242AC130003") as! [Bool]
    mutating func quizCompletion(uuid: String) {
        switch uuid {
        case "EDCD038C-036F-4C40-826F-61C88CD84DDD":
            eras[0] = true
            UserDefaults.standard.set(true, forKey: "EDCD038C-036F-4C40-826F-61C88CD84DDD")
            UserDefaults.standard.set(eras, forKey: "EF1CC5BB-4785-4D8E-AB98-5FA4E00B6A66")
        case "36A7CC40-18C1-48E5-BCD8-3B42D43BEAEE":
            eras[1] = true
            UserDefaults.standard.set(true, forKey: "36A7CC40-18C1-48E5-BCD8-3B42D43BEAEE")
            UserDefaults.standard.set(eras, forKey: "EF1CC5BB-4785-4D8E-AB98-5FA4E00B6A66")
        case "313952E9-84EB-4198-A74F-95827E1F7476":
            eras[2] = true
            UserDefaults.standard.set(true, forKey: "313952E9-84EB-4198-A74F-95827E1F7476")
            UserDefaults.standard.set(eras, forKey: "EF1CC5BB-4785-4D8E-AB98-5FA4E00B6A66")
        case "D44AAEBC-BF4F-42CD-8C37-0FEF772A5B69":
            ancientCivilisations[0] = true
            UserDefaults.standard.set(true, forKey: "D44AAEBC-BF4F-42CD-8C37-0FEF772A5B69")
            UserDefaults.standard.set(ancientCivilisations, forKey: "3D97FAB4-50AC-40FC-9BF0-3F46BB6A92F5")
        case "2BAD20C5-D007-4BBE-B074-8CF0F256A42F":
            ancientCivilisations[1] = true
            UserDefaults.standard.set(true, forKey: "2BAD20C5-D007-4BBE-B074-8CF0F256A42F")
            UserDefaults.standard.set(ancientCivilisations, forKey: "3D97FAB4-50AC-40FC-9BF0-3F46BB6A92F5")
        case "759527CB-1064-4082-A527-F04698F9D18F":
            ancientCivilisations[2] = true
            UserDefaults.standard.set(true, forKey: "759527CB-1064-4082-A527-F04698F9D18F")
            UserDefaults.standard.set(ancientCivilisations, forKey: "3D97FAB4-50AC-40FC-9BF0-3F46BB6A92F5")
        case "D3268150-2DB8-40B4-B504-0FB81EBF7EE5":
            ancientCivilisations[3] = true
            UserDefaults.standard.set(true, forKey: "D3268150-2DB8-40B4-B504-0FB81EBF7EE5")
            UserDefaults.standard.set(ancientCivilisations, forKey: "3D97FAB4-50AC-40FC-9BF0-3F46BB6A92F5")
        case "AB7E38EA-05A7-426A-AFF3-B3A32B3E86BF":
           revolutions[0] = true
           UserDefaults.standard.set(true, forKey: "AB7E38EA-05A7-426A-AFF3-B3A32B3E86BF")
            UserDefaults.standard.set(revolutions, forKey: "1C89DAFD-7653-4EF2-BF20-C51A159BAC43")
        case "758ABBE3-F338-4F7C-BAC7-8D61BC1FB329":
            revolutions[1] = true
            UserDefaults.standard.set(true, forKey: "758ABBE3-F338-4F7C-BAC7-8D61BC1FB329")
            UserDefaults.standard.set(revolutions, forKey: "1C89DAFD-7653-4EF2-BF20-C51A159BAC43")
        case "A73E2D2D-D53A-46D4-8829-62011EEF7DA4":
            revolutions[2] = true
            UserDefaults.standard.set(true, forKey: "A73E2D2D-D53A-46D4-8829-62011EEF7DA4")
            UserDefaults.standard.set(revolutions, forKey: "1C89DAFD-7653-4EF2-BF20-C51A159BAC43")
        case "A4D89AF9-190E-4409-B924-AABD13DBB6A4":
            americainRevolution[0] = true
             UserDefaults.standard.set(true, forKey: "A4D89AF9-190E-4409-B924-AABD13DBB6A4")
            UserDefaults.standard.set(americainRevolution, forKey: "CE3C67F9-79E3-46E3-B134-362A52ABFE3C")
        case "FC201614-1418-4152-9469-087B27485D13":
            americainRevolution[1] = true
            UserDefaults.standard.set(true, forKey: "FC201614-1418-4152-9469-087B27485D13")
            UserDefaults.standard.set(americainRevolution, forKey: "CE3C67F9-79E3-46E3-B134-362A52ABFE3C")
        case "7A2A79EB-5816-4815-B1DD-1D250FB85419":
            americainRevolution[2] = true
            UserDefaults.standard.set(true, forKey: "7A2A79EB-5816-4815-B1DD-1D250FB85419")
            UserDefaults.standard.set(americainRevolution, forKey: "CE3C67F9-79E3-46E3-B134-362A52ABFE3C")
        case "72A68104-7CF8-11EA-BC55-0242AC130003":
            frenchRevolution[0] = true
            UserDefaults.standard.set(true, forKey: "72A68104-7CF8-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(frenchRevolution, forKey: "72A67ED4-7CF8-11EA-BC55-0242AC130003")
        case "CC1538E8-81B2-11EA-BC55-0242AC130003":
            frenchRevolution[1] = true
            UserDefaults.standard.set(true, forKey: "CC1538E8-81B2-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(frenchRevolution, forKey: "72A67ED4-7CF8-11EA-BC55-0242AC130003")
        case "2ECE6909-1295-4AED-AF72-AE875A1DE033":
            frenchRevolution[2] = true
            UserDefaults.standard.set(true, forKey: "2ECE6909-1295-4AED-AF72-AE875A1DE033")
            UserDefaults.standard.set(frenchRevolution, forKey: "72A67ED4-7CF8-11EA-BC55-0242AC130003")
        case "6F2D0B7E-7B4A-11EA-BC55-0242AC130003":
            UserDefaults.standard.set(true, forKey: "6F2D0B7E-7B4A-11EA-BC55-0242AC130003")
            wars[0] = true
             UserDefaults.standard.set(wars, forKey: "6F2D0E08-7B4A-11EA-BC55-0242AC130003")
        case "6F2D0F0C-7B4A-11EA-BC55-0242AC130003":
            wars[1] = true
            UserDefaults.standard.set(true, forKey: "6F2D0F0C-7B4A-11EA-BC55-0242AC130003")
             UserDefaults.standard.set(wars, forKey: "6F2D0E08-7B4A-11EA-BC55-0242AC130003")
        case "6F2D0FF2-7B4A-11EA-BC55-0242AC130003":
            wars[2] = true
             UserDefaults.standard.set(true, forKey: "6F2D0FF2-7B4A-11EA-BC55-0242AC130003")
             UserDefaults.standard.set(wars, forKey: "6F2D0E08-7B4A-11EA-BC55-0242AC130003")
        case "6F2D13C6-7B4A-11EA-BC55-0242AC130003":
            wars[3] = true
            UserDefaults.standard.set(true, forKey: "6F2D13C6-7B4A-11EA-BC55-0242AC130003")
             UserDefaults.standard.set(wars, forKey: "6F2D0E08-7B4A-11EA-BC55-0242AC130003")
        case "EEAE44EC-4A8B-4A56-A1F8-8F0F784DF143":
            wars[4] = true
            UserDefaults.standard.set(true, forKey: "EEAE44EC-4A8B-4A56-A1F8-8F0F784DF143")
             UserDefaults.standard.set(wars, forKey: "6F2D0E08-7B4A-11EA-BC55-0242AC130003")
        case "ECBDF0A4-7D9C-11EA-BC55-0242AC130003":
            napoleon[0] = true
            UserDefaults.standard.set(true, forKey: "ECBDF0A4-7D9C-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(napoleon, forKey: "DF3685AA-7D9B-11EA-BC55-0242AC130003")
        case "ECBDF342-7D9C-11EA-BC55-0242AC130003":
            napoleon[1] = true
            UserDefaults.standard.set(true, forKey: "ECBDF342-7D9C-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(napoleon, forKey: "DF3685AA-7D9B-11EA-BC55-0242AC130003")
        case "ECBE47DE-7D9C-11EA-BC55-0242AC130003":
           napoleon[2] = true
           UserDefaults.standard.set(true, forKey: "ECBE47DE-7D9C-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(napoleon, forKey: "DF3685AA-7D9B-11EA-BC55-0242AC130003")
        case "6F2D15C4-7B4A-11EA-BC55-0242AC130003":
            americainCivilWar[0] = true
            UserDefaults.standard.set(true, forKey: "6F2D15C4-7B4A-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(americainCivilWar, forKey: "6F2D14E8-7B4A-11EA-BC55-0242AC130003")
        case "6F2D1696-7B4A-11EA-BC55-0242AC130003":
            americainCivilWar[1] = true
            UserDefaults.standard.set(true, forKey: "6F2D1696-7B4A-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(americainCivilWar, forKey: "6F2D14E8-7B4A-11EA-BC55-0242AC130003")
        case "4A779C76-9A47-41EE-BAE3-2D0CC472F569":
            americainCivilWar[2] = true
            UserDefaults.standard.set(true, forKey: "4A779C76-9A47-41EE-BAE3-2D0CC472F569")
            UserDefaults.standard.set(americainCivilWar, forKey: "6F2D14E8-7B4A-11EA-BC55-0242AC130003")
        case "7AC5D9FA-81B4-11EA-BC55-0242AC130003":
            ww1[0] = true
            UserDefaults.standard.set(true, forKey: "7AC5D9FA-81B4-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(ww1, forKey: "6F2D192A-7B4A-11EA-BC55-0242AC130003")
        case "73DC7840-A0C9-47E5-9CE9-18B3662DABDE":
            ww1[1] = true
            UserDefaults.standard.set(true, forKey: "73DC7840-A0C9-47E5-9CE9-18B3662DABDE")
            UserDefaults.standard.set(ww1, forKey: "6F2D192A-7B4A-11EA-BC55-0242AC130003")
        case "6F2D1C68-7B4A-11EA-BC55-0242AC130003":
            ww2[0] = true
            UserDefaults.standard.set(true, forKey: "6F2D1C68-7B4A-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(ww2, forKey: "6F2D1B82-7B4A-11EA-BC55-0242AC130003")
        case "6F2D1D44-7B4A-11EA-BC55-0242AC130003":
            ww2[1] = true
            UserDefaults.standard.set(true, forKey: "6F2D1D44-7B4A-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(ww2, forKey: "6F2D1B82-7B4A-11EA-BC55-0242AC130003")
        case "4C8622A4-3FA3-4C4E-BBE9-5A3CC1DD46F8":
            ww2[2] = true
            UserDefaults.standard.set(true, forKey: "4C8622A4-3FA3-4C4E-BBE9-5A3CC1DD46F8")
            UserDefaults.standard.set(ww2, forKey: "6F2D1B82-7B4A-11EA-BC55-0242AC130003")
        case "6F2D1F9C-7B4A-11EA-BC55-0242AC130003":
            space[0] = true
            UserDefaults.standard.set(true, forKey: "6F2D1F9C-7B4A-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(space, forKey: "6F2D1EAC-7B4A-11EA-BC55-0242AC130003")
        case "6F2D2186-7B4A-11EA-BC55-0242AC130003":
            space[1] = true
            UserDefaults.standard.set(true, forKey: "6F2D2186-7B4A-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(space, forKey: "6F2D1EAC-7B4A-11EA-BC55-0242AC130003")
        case "6F2D2258-7B4A-11EA-BC55-0242AC130003":
            space[2] = true
            UserDefaults.standard.set(true, forKey: "6F2D2258-7B4A-11EA-BC55-0242AC130003")
            UserDefaults.standard.set(space, forKey: "6F2D1EAC-7B4A-11EA-BC55-0242AC130003")
        case "8231498C-24CA-4CD7-94B5-AF3F1D22A8FD":
            space[3] = true
            UserDefaults.standard.set(true, forKey: "8231498C-24CA-4CD7-94B5-AF3F1D22A8FD")
            UserDefaults.standard.set(space, forKey: "6F2D1EAC-7B4A-11EA-BC55-0242AC130003")
        default:
           print("default6")
        }
    }
}
