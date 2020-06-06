//
//  ApStoreFeedBack.swift
//  PaintingsAndArtists
//
//  Created by Normand Martin on 2018-11-05.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import Foundation
import StoreKit

class AppStoreFeedBack {
    class func askForFeedback() {
        let points = UserDefaults.standard.integer(forKey: "points")
        let askedOnce = UserDefaults.standard.bool(forKey: "askedOnce")
        let askedTwice = UserDefaults.standard.bool(forKey: "askedTwice")
        let askedThree = UserDefaults.standard.bool(forKey: "askedThree")
        if #available( iOS 10.3,*){
            if points > 110 && !askedOnce{
                SKStoreReviewController.requestReview()
                UserDefaults.standard.set(true, forKey: "askedOnce")
            }else if points > 310 && !askedTwice {
                SKStoreReviewController.requestReview()
                 UserDefaults.standard.set(true, forKey: "askedTwice")
            }else if points > 510 && !askedThree{
                SKStoreReviewController.requestReview()
                UserDefaults.standard.set(true, forKey: "askedThree")
            }
        }
    }
    
}
