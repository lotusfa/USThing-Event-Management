//
//  EventListTableViewCell.swift
//  TryWorkShop
//
//  Created by Ka Wing Leung on 19/2/2017.
//  Copyright © 2017年 1.0. All rights reserved.
//

import UIKit

class EventListTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var location: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
