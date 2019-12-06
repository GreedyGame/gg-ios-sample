//
//  Model.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 06/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation
import UIKit

enum Type{
    case Ad
    case content
}

struct Discover {
    let image:String?
    let name:String?
    let location:String?
    var type:Type?
    
    init(image:String?, name:String?, location:String?, type:Type) {
        self.image = image
        self.name = name
        self.location = location
        self.type = type
    }
}

struct Places {
    let image:String?
    let name:String?
    let location:String?
    let type:Type?
}

