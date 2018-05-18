//
//  DateHeaderTableViewCell.swift
//  PhillySportsLeague
//
//  Created by Tomer Shemesh on 5/18/18.
//  Copyright © 2018 Tomer Shemesh. All rights reserved.
//

import UIKit

class DateHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var expandedArrow: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
