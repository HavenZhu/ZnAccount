//
//  ZNAccountDetailTableViewCell.swift
//  Account
//
//  Created by zhuning on 16/12/7.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNAccountDetailTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var tfContent: UITextField!
    
    // MARK: -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
