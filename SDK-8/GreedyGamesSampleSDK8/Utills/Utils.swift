//
//  Utils.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 09/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

/** Utillity */
import Foundation
import UIKit

class Utill{
    
    static let TAG = "Utill"
    
    
    /// openSafari method will used to open safari with the passed url parameter
    ///
    /// - Parameter url: url to be opened in Safari
    static func openSafari(with url:String){
        Log.d(for: TAG, message: "Trying to open safari")
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: url)!, options: [ : ]) { (success) in
                if !success {
                   print("[ERROR] Not able to open redirection url")
                }
            }
        } else {//ios 9
            // Fallback on earlier versions
            let isOpened = UIApplication.shared.openURL(URL(string: url)!)
            if !isOpened{
                print("[ERROR] Not able to open redirection url")
            }
        }
    }
}
