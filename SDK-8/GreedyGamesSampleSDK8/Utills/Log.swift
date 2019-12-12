//
//  Log.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 10/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//


/** Custom class to print the logs in Console with some defined format/structure*/
import Foundation

class Log{
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    static func d(for tag:String, message:String, line:Int = #line){
        print("\(Date().toString()) [📝] GG[\(tag)] | \(line) : \(message) ")
    }
    
}

internal extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}
