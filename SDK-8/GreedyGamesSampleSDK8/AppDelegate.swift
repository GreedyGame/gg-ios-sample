//
//  AppDelegate.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 04/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit
import greedygame

enum State{
    case Available
    case UnAvailable
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private final let TAG = "App_del"
    var window: UIWindow?
    
    var greedyAgent: GreedyGameAgent?
    var ggDelegate : GGCampaignDelegate?
    var campaignState : State = .Available
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loadSDK()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate : CampaignStateListener{
    
    private func loadSDK(){
        Log.d(for: TAG, message: "Initializing GG SDK")
        greedyAgent = GreedyGameAgent.Builder()
                        .setGameId("39254904")
                        .setUnits(units: ["float-4349","float-4350","float-4351","float-4352","float-4353","float-4354"])
                        .enableAdmob(true)
                        .stateListener(self)
                        .build()
        greedyAgent?.initialize()
    }
    
    func onAvailable(campaignId: String) {
        Log.d(for: TAG, message: "Campaign Available : \(campaignId)")
        ggDelegate?.GGAvailable()
        Prepare.sharedInstance().addAdData()
    }
    
    func onUnavailable() {
        Log.d(for: TAG, message: "Campaign UnAvailable")
        startTimer()
        ggDelegate?.GGUnAvailable()
        Prepare.sharedInstance().removeAdData()
    }
    
    func onError(error: String) {
        Log.d(for: TAG, message: "Campaign Error: \(error)")
        startTimer()
        ggDelegate?.GGUnAvailable()
        Prepare.sharedInstance().removeAdData()
    }
    
    func openGGEngageMentWindow(forunitID id:String){
        
        Log.d(for: TAG, message: "showing engagement window for the unit id: \(id)")
        self.greedyAgent?.showUII(unitId: id)
    }
    
    func getImageFromPath(forunitID id:String) -> UIImage?{
        startTimer()

        Log.d(for: TAG, message: "trying to get the image for the unit id: \(id)")
        guard let imagePath = self.greedyAgent?.getPath(unitId: id),let image = UIImage(contentsOfFile: imagePath) else{
            return nil
        }
        return image
    }
    
    private func startTimer(){
        Log.d(for: TAG, message: "Timer started")

        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { (timer) in
            Log.d(for: self.TAG, message: "60 seconds done, Going to refresh the GreedyGame SDK")
            self.greedyAgent?.refresh()
        }
    }

}
