//
//  DashboardTableViewCell.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 4/23/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class DashboardTableViewCell: CardTableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var leagueName: UIButton!
    @IBOutlet weak var teamName: UIButton!
    @IBOutlet weak var leagueLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        createShadow(cardView: self.cardView)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
