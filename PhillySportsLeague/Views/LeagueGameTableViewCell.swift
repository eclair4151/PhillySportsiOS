//
//  LeagueGameTableViewCell.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/3/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class LeagueGameTableViewCell: CardTableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var team1Button: UIButton!
    @IBOutlet weak var team2Button: UIButton!
    @IBOutlet weak var team1Score: UILabel!
    @IBOutlet weak var team2Score: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var sideColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        createShadow(cardView: self.cardView)
    }
    
}
