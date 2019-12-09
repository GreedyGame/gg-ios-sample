//
//  ViewController.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 04/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var textAdUnit: UIView!
    @IBOutlet weak var textAdunitimagView: UIImageView!
    
  
    
    
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    @IBOutlet weak var newPlacesColletctionView: UICollectionView!
    @IBOutlet weak var userViewCollectionView: UICollectionView!
    @IBOutlet weak var textAdUnitWidth: NSLayoutConstraint!
    
    @IBOutlet weak var pagectrl: UIPageControl!
    var isGGCampaigAvailable = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pagectrl.numberOfPages = Prepare.sharedInstance().discoverlist.count

    }
    
    @IBAction func textAdUnitbtnAction(_ sender: Any) {
        (UIApplication.shared.delegate as! AppDelegate).greedyAgent?.showUII(unitId: "float-4353")
    }
    
    @IBAction func pagectrlAction(_ sender: UIPageControl) {
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
                // TODO:
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

/*extension ViewController : GGCampaignDelegate{
    func GGAvailable() {
        print("[vc] Available")
        isGGCampaigAvailable = true
        update()
    }
    
    func GGUnAvailable() {
        print("[vc] UnAvailable")
        isGGCampaigAvailable = false
        update()
    }
    
    
    /// Helper method to  update the list with GreedyGame templates when ever the campaign available
    private func update(){
        print("update called")
        updateList()
        discoverCollectionView.reloadData()
        newPlacesColletctionView.reloadData()
    }
    
    
    /// update the list
    private func updateList(){
        /*discoverlist.insert("", at: 3)
        discoverlist.append("")
        discoverPlace.insert("", at: 3)
        discoverPlace.append("")
        discoverLocation.insert("", at: 3)
        discoverLocation.append("")
        
        newPlaceList.insert("", at: 3)
        newPlaceList.append("")
        place.insert("", at: 3)
        place.append("")
        newPlace_loc.insert("", at: 3)
        newPlace_loc.append("")*/
        
        
        var c = [discoverlist, discoverPlace, discoverLocation, newPlaceList, place, newPlace_loc]

        for i in 0..<c.count{
            print("i:\(c[i])")
            c[i] = UpdateList(list: &c[i])
        }
    }
    
    private func UpdateList( list:inout [String]) ->  [String]{
        if isGGCampaigAvailable{
            if list.count == 5{
                list.insert("", at: 3)
                list.append("")
                print("After adding : \(list)")
                return list
            }
        }else{
            if list.count == 7{
                list.remove(at: 3)
                list.remove(at: 7)
                print("After removing : \(list)")
                return list
            }
        }
        
        return list
    }
    
   
    
}*/

