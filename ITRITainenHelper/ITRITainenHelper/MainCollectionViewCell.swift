//
//  MainCollectionViewCell.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/25/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    var number: Int
    
    override init(frame: CGRect) {
        self.number = 0
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
