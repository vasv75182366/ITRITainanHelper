//
//  AdministrativeUnitInCategory.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

class AdministrativeUnitInCategory {
    var unitId: String?
    var categoryId: String?
    var lastUpdateTime: Int64!
    
    init() {
        
    }
    
    init(unitId: String, categoryId: String, lastUpdateTime: Int64) {
        self.unitId = unitId
        self.categoryId = categoryId
        self.lastUpdateTime = lastUpdateTime
    }
    
}
