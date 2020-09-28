//
//  noticeTableViewCell.swift
//  summerHomeWork
//
//  Created by WooL on 2020/9/15.
//  Copyright © 2020 WooL. All rights reserved.
//

import UIKit

class noticeTableViewCell: UITableViewCell {

    @IBOutlet weak var noticeTimeLab: UILabel!
    @IBOutlet weak var noticeContentLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
