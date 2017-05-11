//
//  ActivityCell.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/11.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var btn: UIButton!
    
    var onButtonTapped : (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
