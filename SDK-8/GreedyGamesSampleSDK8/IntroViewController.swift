//
//  IntroViewController.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 05/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var introCollectionView: UICollectionView!
    
    @IBOutlet weak var pageCtrl: UIPageControl!
    let headerList = ["For Publishers", "For Advertiser"]
    let descriptionList = ["Solving two key issues was important for native to be a viable ad strategy for publishers – placement rule-set and fill-rate. With our product suite, publishers can now implement native ads with ease, automate design optimization to improve CTR for a considerable jump in revenue.", "User experience is key for us. Any ad from our platform is quality, compliant, relevant and most importantly opt-in. This results into effective outcome metrics for the advertiser and non-intrusive ads for the user automatically."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introCollectionView.register(UINib(nibName: "IntroCell", bundle: nil), forCellWithReuseIdentifier: Constants.INTRO_CELL)

        introCollectionView.delegate = self
        introCollectionView.dataSource = self
    }
    
    @IBAction func pageCtrlAction(_ sender: UIPageControl) {
    }
    
    @IBAction func knowMoreBtnAction(_ sender: UIButton) {
        Utill.openSafari(with: Constants.GG_URL)
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
