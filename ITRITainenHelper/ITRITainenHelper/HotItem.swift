//
//  HotItem.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation


class HotItem {
    var id: Int64!   // primary key auto increment
    var hotDate: String?
    var hotTitle: String?
    var hotDescription: String?
    var hotLink: String?
    var isDelete: Int64!
    
    init() {
        self.isDelete = 0
    }
    
    init(id: Int64, hotDate: String, hotTitle: String, hotDescription: String, hotLink: String, isDelete: Int64) {
        self.id = id
        self.hotDate = hotDate
        self.hotTitle = hotTitle
        self.hotDescription = hotDescription
        self.hotLink = hotLink
        self.isDelete = isDelete
    }
    
}
