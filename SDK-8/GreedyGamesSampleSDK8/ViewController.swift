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
    @IBOutlet weak var textAdUnitWidth: NSLayoutConstraint!
    
    var isGGCampaigAvailable = false
    
    var discoverlist = ["1","2","3","5","6"]
    var discoverPlace = ["Antelope \nCanyon", "Beach \nMaldives", "Amristar \nFort", "Malibu Island", "Eiffel \nTower"]
    var discoverLocation = ["Arizona, USA", "Maldives", "Amrister, India", "California, USA", "Paris, France"]
    
    var newPlaceList = ["p1","p2","p3", "s4","s5"]
    var place = ["Causeway Island", "castle", "River Aga", "The Mosque", "The Valley"]
    var newPlace_loc = ["Ireland", "Iceland", "venice", "Turkey", "Baghdad"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (UIApplication.shared.delegate as! AppDelegate).ggDelegate = self
        switch (UIApplication.shared.delegate as! AppDelegate).campaignState{
        case .Available:
            isGGCampaigAvailable = true
            update()
        case .UnAvailable:
            isGGCampaigAvailable = false
            update()
        }
    }
    
    @IBAction func textAdUnitbtnAction(_ sender: Any) {
        (UIApplication.shared.delegate as! AppDelegate).greedyAgent?.showUII(unitId: "float-4353")
    }
    
    private func registerCell(){
        discoverCollectionView.register(UINib(nibName: "DiscoverCell", bundle: nil), forCellWithReuseIdentifier: Constants.DISCOVER_CELL)
        newPlacesColletctionView.register(UINib(nibName: "PlacesCell", bundle: nil), forCellWithReuseIdentifier: Constants.PLACE_CELL)
        
        discoverCollectionView.delegate = self
        discoverCollectionView.dataSource = self
        newPlacesColletctionView.delegate = self
        newPlacesColletctionView.dataSource = self
    }
    
}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == discoverCollectionView{
            return discoverlist.count
        }else{
            return newPlaceList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView == discoverCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.DISCOVER_CELL, for: indexPath) as! DiscoverCell
            if isGGCampaigAvailable{
                if discoverlist[indexPath.count].isEmpty{
                    cell.mainImageView.image = (UIApplication.shared.delegate as! AppDelegate).getImageFromPath(forunitID: "float-4349") ?? UIImage(named: "")
                }else{
                    cell.mainImageView.image = UIImage(named:discoverlist[indexPath.item])
                    cell.placelbl.text = discoverPlace[indexPath.item]
                    cell.locationlbl.text = discoverLocation[indexPath.item]
                }
            }else{
                cell.mainImageView.image = UIImage(named:discoverlist[indexPath.item])
                cell.placelbl.text = discoverPlace[indexPath.item]
                cell.locationlbl.text = discoverLocation[indexPath.item]
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.PLACE_CELL, for: indexPath) as! PlacesCell
            if isGGCampaigAvailable{
                if newPlaceList[indexPath.item].isEmpty{
                    cell.imageView.image = (UIApplication.shared.delegate as! AppDelegate).getImageFromPath(forunitID: "float-4354") ?? UIImage(named: "")
                }else{
                    cell.imageView.image = UIImage(named: newPlaceList[indexPath.item])
                    cell.placelbl.text = place[indexPath.item]
                    cell.locationlbl.text = newPlace_loc[indexPath.item]
                }
            }else{
                cell.imageView.image = UIImage(named: newPlaceList[indexPath.item])
                cell.placelbl.text = place[indexPath.item]
                cell.locationlbl.text = newPlace_loc[indexPath.item]
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == discoverCollectionView{
            return CGSize(width: collectionView.frame.size.width-10, height: collectionView.frame.size.height)
        }else{
            return CGSize(width: collectionView.frame.size.width/3 - 10, height: collectionView.frame.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isGGCampaigAvailable{
            if discoverlist[indexPath.row].isEmpty{
                if collectionView == discoverCollectionView{
                    openGG(id: "float-4349")
                }else{
                    openGG(id: "float-4354")
                }
            }else{
                openDetailVC(index: indexPath.row)
            }
        }else{
            openDetailVC(index: indexPath.row)
        }
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
    private func openDetailVC(index:Int){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailvc") as! DetailViewController
        
        vc.place = discoverPlace[index]
        vc.location = discoverLocation[index]
        vc.image = discoverlist[index]
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ViewController : GGCampaignDelegate{
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
        var c = [discoverlist, discoverPlace, discoverLocation, newPlaceList, place, newPlace_loc]
        for i in 0..<c.count{
            print("i:[i]")
            UpdateList(list: &c[i])
        }
    }
    
    private func UpdateList( list:inout [String]){
        if isGGCampaigAvailable{
            if list.count == 5{
                list.insert("", at: 3)
                list.append("")
                print("After adding : \(list)")
            }
        }else{
            if list.count == 7{
                list.remove(at: 3)
                list.remove(at: 7)
                print("After removing : \(list)")
            }
        }
    }
    
}

