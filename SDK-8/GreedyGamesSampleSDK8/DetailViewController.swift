//
//  DetailViewController.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 04/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var closebtn: UIButton!
    @IBOutlet weak var placelbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeDetailTemplate_imageView: UIImageView!
    
    var place  = ""
    var location = ""
    var image = ""
    var isGGCampaigAvailable = false
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        place = place.replacingOccurrences(of: "\n", with: "")
        placelbl.text = place
        locationlbl.text = location
        placeImageView.image = UIImage(named: image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch appdelegate.campaignState{
        case .Available:
            isGGCampaigAvailable = true
            update()
        case .UnAvailable:
            isGGCampaigAvailable = false
            update()
        }
    }
    

    @IBAction func closebtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func templateBtnAction(_ sender: UIButton) {
        appdelegate.openGGEngageMentWindow(forunitID: "float-4352")
    }

   
    /// Helper method to updat the template
    private func update(){
        if isGGCampaigAvailable{
            guard let image = appdelegate.getImageFromPath(forunitID: "float-4352") else{
                placeDetailTemplate_imageView.image = UIImage(named: "")
                return
            }
            placeDetailTemplate_imageView.image = image
        }else{
            placeDetailTemplate_imageView.image = UIImage(named: "")
        }
    }
}
