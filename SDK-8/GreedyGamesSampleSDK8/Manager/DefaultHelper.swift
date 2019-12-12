//
//  File.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 10/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

/** DefaultHelper is a class to store/retrive the userdefault value with the*/
import Foundation

class DefaultHelper{
    
    private static let TAG = "Dft_hpr"
    
    private static let defaults = UserDefaults.standard
    
    
    ///  set method used to store the value with the given key in UserDefaults
    ///
    /// - Parameters:
    ///   - value: value to be stored
    ///   - forKey: key for the value to be stored
    static func set(value:Bool, forKey:String){
        defaults.set(value, forKey: forKey)
    }
    
    /// get method used to retrive the value of the given key store in UserDefaults
    ///
    /// - Parameter Key: key to get the respective value of it
    /// - Returns: will return the stored value of the given key
    static func get(value Key:String) -> Bool{
        return defaults.bool(forKey:Key)
    }
    
}
