//
//  HomeTableViewCell.swift
//  WeatherReport
//
//  Created by afouzdar on 29/04/21.
//  Copyright © 2021 Mobiquity. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var labelCity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
