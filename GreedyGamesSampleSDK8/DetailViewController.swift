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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        place = place.replacingOccurrences(of: "\n", with: "")
        placelbl.text = place
        locationlbl.text = location
        placeImageView.image = UIImage(named: image)
    }
    

    @IBAction func closebtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func templateBtnAction(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
