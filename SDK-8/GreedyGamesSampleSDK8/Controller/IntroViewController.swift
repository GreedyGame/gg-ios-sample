//
//  IntroViewController.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 05/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    private final let TAG = "Intr_Vc"
    
    @IBOutlet weak var introCollectionView: UICollectionView!
    @IBOutlet weak var seeDemoBtn: UIButton!
    @IBOutlet weak var activityindicator: UIActivityIndicatorView!
    @IBOutlet weak var knowMorebtn: UIButton!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    let headerList = ["For Publishers", "For Advertiser"]
    let descriptionList = ["Solving two key issues was important for native to be a viable ad strategy for publishers – placement rule-set and fill-rate. With our product suite, publishers can now implement native ads with ease, automate design optimization to improve CTR for a considerable jump in revenue.", "User experience is key for us. Any ad from our platform is quality, compliant, relevant and most importantly opt-in. This results into effective outcome metrics for the advertiser and non-intrusive ads for the user automatically."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        introCollectionView.register(UINib(nibName: "IntroCell", bundle: nil), forCellWithReuseIdentifier: Constants.INTRO_CELL)
        introCollectionView.delegate = self
        introCollectionView.dataSource = self
        showLoader()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Prepare.sharedInstance().delegate = self
    }
    
    //    MARK:  IBAction methods
    @IBAction func pageCtrlAction(_ sender: UIPageControl) {
    }
    
    @IBAction func knowMoreBtnAction(_ sender: UIButton) {
        Utill.openSafari(with: Constants.GG_URL)
    }
    
    //    MARK: Helper Methods
    
    /// Helper method to show the Activity Indicator for campaign Loading
    private func showLoader(){
        activityindicator.isHidden = false
        activityindicator.startAnimating()
        UIView.animate(withDuration: 0.1) {
            self.knowMorebtn.alpha = 0
            self.knowMorebtn.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.seeDemoBtn.alpha = 0
            self.seeDemoBtn.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        }
    }

    /// Helper method to hide the Activity Indicator for once GreedyGame SDK loaded and gets the campaign state callback
    private func hideLoader(){
        activityindicator.isHidden = true
        activityindicator.stopAnimating()
        UIView.animate(withDuration: 0.1) {
            self.knowMorebtn.alpha = 1
            self.knowMorebtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.seeDemoBtn.alpha = 1
            self.seeDemoBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}


// MARK: - CollectionView Delegate, DataSource, DelegateFlowLayout
extension IntroViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.INTRO_CELL, for: indexPath) as! IntroCell
        cell.headerlbl.text = headerList[indexPath.item]
        cell.descriptionlbl.text = descriptionList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if introCollectionView.frame.width == targetContentOffset.pointee.x{
            pageCtrl.currentPage = 1
        }else{
            pageCtrl.currentPage = 0
        }
    }
}


// MARK: - UpdateDelagate
extension IntroViewController : UpdateDelagate{
    func updateAd(state: State) {
        Log.d(for: TAG, message: "Update Called")
        view.makeToast("Campaign \(state.rawValue)")
        hideLoader()
    }
}
