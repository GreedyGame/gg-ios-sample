//
//  DetailCell.swift
//  GreedyGamesSampleSDK8
//
//  Created by Vishnu on 09/12/19.
//  Copyright © 2019 GreedyGame. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    private final let TAG = "Detl_cl"
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var placelbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var templateImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func templateBtnAction(_ sender: UIButton) {
        Log.d(for: TAG, message: "showing GG Engagement window")
        (UIApplication.shared.delegate as! AppDelegate).openGGEngageMentWindow(forunitID: "float-4352")
    }
}
