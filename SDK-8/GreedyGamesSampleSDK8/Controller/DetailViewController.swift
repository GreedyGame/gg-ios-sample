//
//  DetailViewController.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 04/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private final let TAG = "Detl_Vc"

    @IBOutlet weak var detailPlaceTemplateImgView: UIImageView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var closebtn: UIButton!
    @IBOutlet weak var content_tableView: UITableView!

    var place  = ""
    var location = ""
    var image = ""
    var isGGCampaigAvailable = false
    var isTemplateShown = false
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Prepare.sharedInstance().delegate = self
        place = place.replacingOccurrences(of: "\n", with: "")
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeDetailTemplate()
        switch appdelegate.campaignState{
        case .Available:
            isGGCampaigAvailable = true
            updates()
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

   
    private func registerCell(){
        content_tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: Constants.DETAIL_CELL)
        content_tableView.delegate = self
        content_tableView.dataSource = self
    }
    
    /// Helper method to updat the template
    internal func updates(){
        if isGGCampaigAvailable{
            guard let image = appdelegate.getImageFromPath(forunitID: "float-4352") else{
                detailPlaceTemplateImgView.image = UIImage(named: "")
                return
            }
            detailPlaceTemplateImgView.image = image
        }else{
            detailPlaceTemplateImgView.image = UIImage(named: "")
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("Begin draging : \(scrollView.contentOffset)")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Scroll : \(scrollView.contentOffset.y)")
        print("isScrollTop : \(scrollView.scrollsToTop)")
        if !scrollView.scrollsToTop{
            return
        }
        if scrollView.contentOffset.y > 200{
            if !isTemplateShown{
                showDetailTemplate()
            }else{
                closeDetailTemplate()
            }
        }else{
            closeDetailTemplate()
        }
    }
    
    
    private func showDetailTemplate(){
        UIView.animate(withDuration: 0.5) {
            self.adView.transform = CGAffineTransform(translationX: 0, y: 50)
            self.isTemplateShown = true
        }
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
//            self.adView.transform = CGAffineTransform(translationX: 0, y: 50)
//            self.isTemplateShown = true
//        }, completion: nil)
    }
   
    private func closeDetailTemplate(){
        UIView.animate(withDuration: 0.5) {
            self.adView.transform = CGAffineTransform(translationX: 0, y: -50)
            self.isTemplateShown = false
        }
//        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
//            self.adView.transform = CGAffineTransform(translationX: 0, y: -50)
//            self.isTemplateShown = false
//        }, completion: nil)
    }
}

extension DetailViewController : UpdateDelagate{
 
    
    func update(){
        Log.d(for: TAG, message: "Update Called")

        content_tableView.reloadData()
        if appdelegate.campaignState == .Available{
            detailPlaceTemplateImgView.image = appdelegate.getImageFromPath(forunitID: "float-4352")
        }else{
            if isTemplateShown{
                detailPlaceTemplateImgView.image = UIImage(named: "")
                closeDetailTemplate()
            }
        }
    }
    
}
