//
//  ViewController.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 04/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit
import Instructions

class ViewController: UIViewController {
    

    private final let TAG = "Main_Vc"
   
    @IBOutlet weak var textAdUnit: UIView!
    @IBOutlet weak var textAdunitimagView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    @IBOutlet weak var newPlacesColletctionView: UICollectionView!
    @IBOutlet weak var userViewCollectionView: UICollectionView!
    @IBOutlet weak var textAdUnitWidth: NSLayoutConstraint!
    @IBOutlet weak var pagectrl: UIPageControl!
    
    let coachMarksController = CoachMarksController()
    let pointOfInterest = UIView()
    var isGGCampaigAvailable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coachMarksController.dataSource = self
        Prepare.sharedInstance().delegate = self
        coachMarksController.overlay.color = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.8)
        profileImgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTap(tapGesture:)))
        profileImgView.addGestureRecognizer(tap)
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pagectrl.numberOfPages = Prepare.sharedInstance().discoverlist.count
        userViewCollectionView.reloadData()
        discoverCollectionView.reloadData()
        newPlacesColletctionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !DefaultHelper.get(value: Constants.COACH_MARK){
            self.coachMarksController.start(on: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
    }
    
    @IBAction func textAdUnitbtnAction(_ sender: Any) {
        (UIApplication.shared.delegate as! AppDelegate).greedyAgent?.showUII(unitId: "float-4353")
    }
    
    @IBAction func pagectrlAction(_ sender: UIPageControl) {
    }
    
    
    @objc func imageTap(tapGesture:UITapGestureRecognizer){
        if !DefaultHelper.get(value: Constants.PRO_COACH_MARK){
            self.coachMarksController.start(on: self)
            DefaultHelper.set(value: true, forKey: Constants.PRO_COACH_MARK)
        }
    }
    
    private func registerCell(){
        discoverCollectionView.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: Constants.DISCOVER_CELL)
        newPlacesColletctionView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellWithReuseIdentifier: Constants.PLACE_CELL)
        userViewCollectionView.register(UINib(nibName: "UserViewCell", bundle: nil), forCellWithReuseIdentifier: Constants.USER_VIEW_CELL)

        
        discoverCollectionView.register(UINib(nibName: "AdCell", bundle: nil), forCellWithReuseIdentifier: Constants.AD_CELL)
        newPlacesColletctionView.register(UINib(nibName: "AdCell", bundle: nil), forCellWithReuseIdentifier: Constants.AD_CELL)
        userViewCollectionView.register(UINib(nibName: "AdCell", bundle: nil), forCellWithReuseIdentifier: Constants.AD_CELL)
        
        
        discoverCollectionView.delegate = self
        discoverCollectionView.dataSource = self
        newPlacesColletctionView.delegate = self
        newPlacesColletctionView.dataSource = self
        userViewCollectionView.delegate = self
        userViewCollectionView.dataSource = self
    }
    
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == discoverCollectionView{
            return Prepare.sharedInstance().discoverlist.count
        }else if collectionView == newPlacesColletctionView{
            return Prepare.sharedInstance().placelist.count
        }else{
            return Prepare.sharedInstance().userViewList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == discoverCollectionView{
            let obj = Prepare.sharedInstance().discoverlist[indexPath.item]
            if obj.type == Type.content{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                    Constants.DISCOVER_CELL, for: indexPath) as! DiscoverCell
                cell.mainImageView.image = UIImage(named:obj.image ?? "")
                cell.placelbl.text = obj.name
                cell.locationlbl.text = obj.location
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.AD_CELL, for: indexPath) as! AdCell
                cell.adimageView.image = (UIApplication.shared.delegate as! AppDelegate).getImageFromPath(forunitID: "float-4349") ?? UIImage(named: "")
                return cell
            }
            
        }else if collectionView == newPlacesColletctionView{
            let obj = Prepare.sharedInstance().placelist[indexPath.item]
            if obj.type == Type.content{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                    Constants.PLACE_CELL, for: indexPath) as! PlacesCell
                cell.imageView.image = UIImage(named:obj.image ?? "")
                cell.placelbl.text = obj.name
                cell.locationlbl.text = obj.location
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.AD_CELL, for: indexPath) as! AdCell
                cell.adimageView.image = (UIApplication.shared.delegate as! AppDelegate).getImageFromPath(forunitID: "float-4354") ?? UIImage(named: "")
                return cell
            }
        }else{
            let obj = Prepare.sharedInstance().userViewList[indexPath.row]
            if obj.type == Type.content{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.USER_VIEW_CELL, for: indexPath) as! UserViewCell
                cell.titlelbl?.text = obj.title
                if indexPath.row == 0{
                    cell.titlelbl.textColor = .orange
                    cell.titlelbl.font = UIFont.boldSystemFont(ofSize: 15)
                }else{
                    cell.titlelbl.textColor = .black
                    cell.titlelbl.font = UIFont.systemFont(ofSize: 10)
                }
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.AD_CELL, for: indexPath) as! AdCell
                cell.adimageView.image = (UIApplication.shared.delegate as! AppDelegate).getImageFromPath(forunitID: "float-4353") ?? UIImage(named: "")
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == discoverCollectionView{
            return CGSize(width: collectionView.frame.size.width-10, height: collectionView.frame.size.height)
        }else if collectionView ==  newPlacesColletctionView{
            return CGSize(width: collectionView.frame.size.width/3 - 10, height: collectionView.frame.size.height)
        }else{
            if indexPath.row == 1{
                return CGSize(width: 100, height: 50)
            }else{
                return CGSize(width: collectionView.frame.size.width/4, height: 50)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = Prepare.sharedInstance().discoverlist[indexPath.item]
    
        if obj.type == .content{
            if collectionView == discoverCollectionView{
                openDetailVC(with: obj)
            }
        }else{
            if collectionView == discoverCollectionView{
                openGG(id: "float-4349")
            }else if collectionView == newPlacesColletctionView{
                openGG(id: "float-4354")
            }else{
                openGG(id: "float-4353")
            }
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPage = (targetContentOffset.pointee.x/discoverCollectionView.frame.size.width)
        pagectrl.currentPage = Int(currentPage)
    }
    
    
    /// Helper method to show GreedyGame Engagement window
    ///
    /// - Parameter id: unit id
    private func openGG(id:String){
        (UIApplication.shared.delegate as! AppDelegate).greedyAgent?.showUII(unitId: id)
    }
    
    
    /// Helper method to present the place detail viewcontroller
    ///
    /// - Parameter index: the data in repsective index of the place Details to be send to detail VC
    private func openDetailVC(with object:Discover){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailvc") as! DetailViewController
        
        vc.place = object.name ?? ""
        vc.location = object.location ?? ""
        vc.image = object.image ?? ""
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ViewController : CoachMarksControllerDataSource, CoachMarksControllerDelegate{
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return 3
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        
        switch  index {
        case 0:
            return coachMarksController.helper.makeCoachMark(for: userViewCollectionView, pointOfInterest: nil, cutoutPathMaker: nil)
        case 1:
             return coachMarksController.helper.makeCoachMark(for: discoverCollectionView, pointOfInterest: CGPoint(x: discoverCollectionView.frame.width/2, y: 0), cutoutPathMaker: nil)
        case 2:
             return coachMarksController.helper.makeCoachMark(for: profileImgView, pointOfInterest: nil, cutoutPathMaker: nil)
        default:
            break
        }
        return coachMarksController.helper.makeCoachMark(for: profileImgView, pointOfInterest: nil, cutoutPathMaker: nil)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: CoachMarkBodyView, arrowView: CoachMarkArrowView?) {

        switch index {
        case 0:
            let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
            coachViews.bodyView.hintLabel.text = "Place them anyWhere! \n      \n Our adUnits are versatile.Unlimited customization for the perfect look you need"
            
            coachViews.bodyView.hintLabel.textAlignment = .center
            coachViews.bodyView.hintLabel.font = UIFont(name: "poppins", size: 13)
            coachViews.bodyView.hintLabel.font = UIFont.boldSystemFont(ofSize: 13)
            
            coachViews.bodyView.nextLabel.text = "Ad"
            coachViews.bodyView.nextLabel.textColor = .orange
            coachViews.bodyView.nextLabel.font = UIFont.boldSystemFont(ofSize: 20)
            coachViews.bodyView.nextLabel.font = UIFont(name: "poppins", size: 20)
            
            
            return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
        case 1:
            let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
            coachViews.bodyView.hintLabel.text = "Get more user engagement with the ad! \n\n place ads in between content.You improve your chances of a click and no on-the-face ads.WIN-WIN!!!"
            coachViews.bodyView.hintLabel.textAlignment = .center
            coachViews.bodyView.hintLabel.font = UIFont(name: "poppins", size: 15)
            coachViews.bodyView.hintLabel.font = UIFont.boldSystemFont(ofSize: 15)
            
            coachViews.bodyView.nextLabel.text = "Ad"
            coachViews.bodyView.nextLabel.textColor = .orange
            coachViews.bodyView.nextLabel.font = UIFont.boldSystemFont(ofSize: 20)
            coachViews.bodyView.nextLabel.font = UIFont(name: "poppins", size: 20)
            
            return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
        case 2:
            let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
            coachViews.bodyView.hintLabel.text = "Wanns see again tap and Click above"
            coachViews.bodyView.hintLabel.textAlignment = .center
            coachViews.bodyView.hintLabel.font = UIFont(name: "poppins", size: 15)
            coachViews.bodyView.hintLabel.font = UIFont.boldSystemFont(ofSize: 15)
            
            coachViews.bodyView.nextLabel.text = "😎"
            coachViews.bodyView.nextLabel.textColor = .orange
            coachViews.bodyView.nextLabel.font = UIFont.boldSystemFont(ofSize: 20)
            coachViews.bodyView.nextLabel.font = UIFont(name: "poppins", size: 20)
            
            DefaultHelper.set(value: true, forKey: Constants.COACH_MARK)

            return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
            
        default:
            break

        }
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
}

extension ViewController : UpdateDelagate{
    
    internal func update(){
      updateVC()
    }
    
    private func updateVC(){
        pagectrl.numberOfPages = Prepare.sharedInstance().discoverlist.count
        userViewCollectionView.reloadData()
        discoverCollectionView.reloadData()
        newPlacesColletctionView.reloadData()
    }
}
