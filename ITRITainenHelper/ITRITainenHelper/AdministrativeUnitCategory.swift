//
//  AdministrativeUnitCategory.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

class AdministrativeUnitCategory {
    var categoryId: String?
    var name: String?
    var description: String?
    var iconName: String?
    var createTime: Int64!
    var lastUpdateTime: Int64!
    var keyword: String?
    
    init() {
        
    }
    
    init(categoryId: String, name: String, description: String, iconName: String, createTime: Int64, lastUpdateTime: Int64, keyword: String) {
        self.categoryId = categoryId
        self.name = name
        self.description = description
        self.iconName = iconName
        self.createTime = createTime
        self.lastUpdateTime = lastUpdateTime
        self.keyword = keyword
    }
    
}
