//
//  File.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 10/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class DefaultHelper{
    
    private static let TAG = "Dft_hpr"
    
    private static let defaults = UserDefaults.standard
    
    static func get(value Key:String) -> Bool{
        return defaults.bool(forKey:Key)
    }
    
    static func set(value:Bool, forKey:String){
        defaults.set(value, forKey: forKey)
    }
    
}
