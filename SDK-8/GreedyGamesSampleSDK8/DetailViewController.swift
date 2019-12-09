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
    @IBOutlet weak var place_lbl: UILabel!
    @IBOutlet weak var location_lbl: UILabel!
    
    @IBOutlet weak var content_tableView: UITableView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeDetailTemplate_imageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var place  = ""
    var location = ""
    var image = ""
    var isGGCampaigAvailable = false
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
       place = place.replacingOccurrences(of: "\n", with: "")
//        place_lbl.text = place
//        location_lbl.text = location
//        placeImageView.image = UIImage(named: image)
//        scrollView.delegate = self
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch appdelegate.campaignState{
        case .Available:
            isGGCampaigAvailable = true
            //update()
        case .UnAvailable:
            isGGCampaigAvailable = false
            //update()
        }
    }
    

    @IBAction func closebtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func templateBtnAction(_ sender: UIButton) {
        appdelegate.openGGEngageMentWindow(forunitID: "float-4352")
    }

   
    private func registerCell(){
        content_tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: Constants.DETAIL_CELL)
        content_tableView.delegate = self
        content_tableView.dataSource = self
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


extension DetailViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DETAIL_CELL, for: indexPath) as! DetailCell
        cell.mainImage?.image = UIImage(named: image)
        cell.placelbl.text = place
        cell.locationlbl.text = location
        
        switch appdelegate.campaignState{
        case .Available:
            if let image = appdelegate.getImageFromPath(forunitID: "float-4352"){
               cell.templateImgView.image = image
            }else{
                cell.templateImgView.image = UIImage(named: "")
            }

        case .UnAvailable:
            cell.templateImgView.image = UIImage(named: "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Scroll : \(scrollView.contentOffset)")
    }
   
}
