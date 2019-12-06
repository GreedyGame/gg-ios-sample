//
//  Prepare.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 06/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import Foundation

class Prepare : NSObject{
    
    var discoverlist = [Discover]()
    var placelist = [Places]()
    static var instance : Prepare?
    
    override init() {
        super.init()
        prePareData()
    }
    
    static func sharedInstance() -> Prepare{
        if instance == nil{
            instance = Prepare()
        }
        return instance!
    }
    
    private func prePareData() {
        for i in 0..<5{
            let discoverObj = Discover(image: MyData.dImage[i], name: MyData.dPlace[i], location: MyData.dLocation[i], type: .content)
            discoverlist.append(discoverObj)
            
            let placeObj = Places(image: MyData.nImage[i], name: MyData.nPlace[i], location: MyData.nLocation[i], type: .content)
            placelist.append(placeObj)
        }
    }
    
    func addAdData(){
        self.discoverlist.insert(prepareDiscoverAdData(), at: 3)
        self.discoverlist.insert(prepareDiscoverAdData(), at: 5)
        
        self.placelist.insert(preparePlaceAdData(), at: 3)
        self.placelist.insert(preparePlaceAdData(), at: 5)
    }
    
    func removeAdData() {
        if discoverlist.count == 7{
            self.discoverlist.remove(at: 3)
            self.discoverlist.remove(at: 5)
            
            self.placelist.remove(at: 3)
            self.placelist.remove(at: 5)
        }
    }
    
    private func prepareDiscoverAdData() -> Discover{
        let discoverObj = Discover(image: nil, name: nil, location: nil, type: .Ad)
        return discoverObj
    }
    
    private func preparePlaceAdData() -> Places{
        let placeObj = Places(image: nil, name: nil, location: nil, type: .Ad)
        return placeObj
    }
    
}
