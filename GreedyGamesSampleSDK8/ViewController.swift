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
    @IBOutlet weak var discoverCollectionView: UICollectionView!
    @IBOutlet weak var newPlacesColletctionView: UICollectionView!
    
    let discoverlist = ["1","2","3","5","6"]
    let discoverPlace = ["Antelope \nCanyon", "Beach \nMaldives", "Amristar \nFort", "Malibu Island", "Eiffel \nTower"]
    let discoverLocation = ["Arizona, USA", "Maldives", "Amrister, India", "California, USA", "Paris, France"]
    
    let newPlaceList = ["p1","p2","p3", "s4","s5"]
    let place = ["Causeway Island", "castle", "River Aga", "The Mosque", "The Valley"]
    let newPlace_loc = ["Ireland", "Iceland", "venice", "Turkey", "Baghdad"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
//        if segue.identifier == Constants.DETAIL_VC_SEGUE{
//            let detailvc = segue.destination as! DetailViewController
//            navigationController?.present(detailvc, animated: true, completion: nil)
//        }
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
            cell.mainImageView.image = UIImage(named:discoverlist[indexPath.row])
            cell.placelbl.text = discoverPlace[indexPath.row]
            cell.locationlbl.text = discoverLocation[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.PLACE_CELL, for: indexPath) as! PlacesCell
            cell.imageView.image = UIImage(named: newPlaceList[indexPath.row])
            cell.placelbl.text = place[indexPath.row]
            cell.locationlbl.text = newPlace_loc[indexPath.row]
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
//        if collectionView == discoverCollectionView{
//            performSegue(withIdentifier: Constants.DETAIL_VC_SEGUE, sender: nil)
//        }
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailvc") as! DetailViewController

        vc.place = discoverPlace[indexPath.row]
        vc.location = discoverLocation[indexPath.row]
        vc.image = discoverlist[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
}
