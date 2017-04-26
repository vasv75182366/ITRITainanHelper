//
//  administrativeUnit.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

class AdministrativeUnit {
    var x: Int64!
    var y: Int64!
    var fieldId: String?
    var unitId: String?
    var parentUnitId: String?
    var name: String?
    var tel: String?
    var fax: String?
    var email: String?
    var website: String?
    var description: String?
    var iconName: String?
    var createTime: Int64!
    var lastUpdateTime: Int64!
    var nearByPathId: String?
    var keyword: String?
    
    init() {
        
    }
    
    init(x: Int64, y: Int64, fieldId: String, unitId: String, parentUnitId: String, name: String, tel: String, fax: String, email: String, website: String, description: String, iconName: String, createTime: Int64, lastUpdateTime: Int64, nearByPathId: String, keyword: String) {
        self.x = x
        self.y = y
        self.fieldId = fieldId
        self.unitId = unitId
        self.parentUnitId = parentUnitId
        self.name = name
        self.tel = tel
        self.fax = fax
        self.email = email
        self.website = website
        self.description = description
        self.iconName = iconName
        self.createTime = createTime
        self.lastUpdateTime = lastUpdateTime
        self.nearByPathId = nearByPathId
        self.keyword = keyword
    }
    
}
