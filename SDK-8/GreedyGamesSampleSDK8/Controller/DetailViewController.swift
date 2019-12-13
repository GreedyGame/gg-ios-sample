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

    @IBOutlet weak var detailplaceTemplateView: UIView!
    @IBOutlet weak var detailPlaceTemplateImgView: UIImageView!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var closebtn: UIButton!
    @IBOutlet weak var content_tableView: UITableView!

    var place  = ""
    var location = ""
    var image = ""
    var isGGCampaigAvailable = false
    var isTemplateShown = false
    var campaignState:State = .UNAVAILABLE
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var cellTemplate : UIImageView?
    var yOffsetValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        place = place.replacingOccurrences(of: "\n", with: "")
        registerCell()
        self.adView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Prepare.sharedInstance().delegate = self

        closeDetailTemplate()
        switch appdelegate.campaignState{
        case .AVAILABLE:
            isGGCampaigAvailable = true
            updates()
        case .UNAVAILABLE:
            isGGCampaigAvailable = false
            updates()
        }
    }

    //   MARK: Button action methods
    @IBAction func closebtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func templateBtnAction(_ sender: UIButton) {
        appdelegate.openGGEngageMentWindow(forunitID: "float-4352")
    }

    
    /// Helper method to register the tableview cell
    private func registerCell(){
        content_tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: Constants.DETAIL_CELL)
        content_tableView.delegate = self
        content_tableView.dataSource = self
    }
    
    /// Helper method to updat the template
    func updates(){
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


// MARK: Tableview Delegate
extension DetailViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if appdelegate.campaignState == .AVAILABLE{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DETAIL_CELL, for: indexPath) as! DetailCell
            cell.mainImage?.image = UIImage(named: image)
            cell.placelbl.text = place
            cell.locationlbl.text = location

            cellTemplate =  cell.templateImgView

            if let image = appdelegate.getImageFromPath(forunitID: "float-4352"){
               cell.templateImgView.image = image
            }else{
                cell.templateImgView.image = UIImage(named: "")
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DETAIL_CELL, for: indexPath) as! DetailCell
            cell.mainImage?.image = UIImage(named: image)
            cell.placelbl.text = place
            cell.locationlbl.text = location
            cellTemplate = cell.templateImgView
            cell.templateImgView.image = UIImage(named: "")
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 200{
            yOffsetValue = Int(scrollView.contentOffset.y)
            if appdelegate.campaignState == .AVAILABLE{
                if !isTemplateShown{
                    showDetailTemplate()
                }else{
                    closeDetailTemplate()
                }
            }else{
                if isTemplateShown{
                    closeDetailTemplate()
                }
            }
        }else{
            closeDetailTemplate()
        }
    }
    
    /// Helper Method to appear the sliding template
    private func showDetailTemplate(){
        UIView.animate(withDuration: 0.5) {
            self.adView.alpha = 1
            self.adView.transform = CGAffineTransform(translationX: 0, y: 50)
            self.isTemplateShown = true
        }
    }
    
    /// Helper Method to disappear the sliding template
    private func closeDetailTemplate(){
        UIView.animate(withDuration: 0.5) {
            self.adView.alpha = 0
            self.adView.transform = CGAffineTransform(translationX: 0, y: -50)
            self.isTemplateShown = false
        }
    }
}

// MARK: UpdateDelegate
extension DetailViewController : UpdateDelagate{
 
    func updateAd(state: State){
        Log.d(for: TAG, message: "Update Called")
        view.makeToast("Campaign \(state.rawValue)")
        campaignState = state
    
        if state == .AVAILABLE{
            detailPlaceTemplateImgView.image = appdelegate.getImageFromPath(forunitID: "float-4352")
            if yOffsetValue > 200{
                showDetailTemplate()
            }else{
                closeDetailTemplate()
            }
            if let image = appdelegate.getImageFromPath(forunitID: "float-4352"){
                cellTemplate?.image = image
            }else{
                cellTemplate?.image = UIImage(named: "")
            }
        }else{
            detailPlaceTemplateImgView.image = UIImage(named: "")
            cellTemplate?.image = UIImage(named: "")
        }
    }
    
}
