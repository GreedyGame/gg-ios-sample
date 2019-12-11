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
    var campignState:State = .UNAVAILABLE
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
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

    @IBAction func closebtnAction(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
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
        case .AVAILABLE:
            if let image = appdelegate.getImageFromPath(forunitID: "float-4352"){
               cell.templateImgView.image = image
            }else{
                cell.templateImgView.image = UIImage(named: "")
            }

        case .UNAVAILABLE:
            cell.templateImgView.image = UIImage(named: "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Scroll : \(scrollView.contentOffset.y)")
        print("isScrollTop : \(scrollView.scrollsToTop)")
//        if !scrollView.scrollsToTop{
//            return
//        }
        print("Dss0")
        
        if scrollView.contentOffset.y > 200{
            print("Dss1")

            if appdelegate.campaignState == .AVAILABLE{
                print("Dss2")

                if !isTemplateShown{
                    print("Dss2")

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
            
//            closeDetailTemplate()
        }
    }
    
    
    private func showDetailTemplate(){
        UIView.animate(withDuration: 0.5) {
            self.adView.alpha = 1
            self.adView.transform = CGAffineTransform(translationX: 0, y: 50)
            self.isTemplateShown = true
        }
    }
   
    private func closeDetailTemplate(){
        UIView.animate(withDuration: 0.5) {
            self.adView.alpha = 0
            self.adView.transform = CGAffineTransform(translationX: 0, y: -50)
            self.isTemplateShown = false
        }
    }
}

extension DetailViewController : UpdateDelagate{
 
    func updateAd(state: State){
        Log.d(for: TAG, message: "Update Called")
        print("DD0")

        view.makeToast(state.rawValue)
        
        campignState = state

//        self.view.setNeedsLayout()
    
        if state == .AVAILABLE{
            print("DD1")
            detailPlaceTemplateImgView.image = appdelegate.getImageFromPath(forunitID: "float-4352")
        }else{
            print("DD2")

            if isTemplateShown{
                print("DD3")
                detailPlaceTemplateImgView.image = UIImage(named: "")
                closeDetailTemplate()
            }
        }
    }
    
}
