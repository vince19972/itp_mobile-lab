//
//  MealTableViewCell.swift
//  MealTrack
//
//  Created by 邵名浦 on 2019/2/19.
//  Copyright © 2019 vinceshao. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

}
