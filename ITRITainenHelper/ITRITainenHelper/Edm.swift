//
//  Edm.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

class Edm {
    var edmId: String!
    var edmName: String?
    var edmURL: String?
    var edmImage: String?
    var edmEndDay: String?
    var lastUpdateTime: Int64!
    
    init() {
        
    }
    
    init(edmId: String, edmName: String, edmURL: String, edmImage: String, edmEndDay: String, lastUpdateTime: Int64) {
        self.edmId = edmId
        self.edmURL = edmURL
        self.edmImage = edmImage
        self.edmEndDay = edmEndDay
        self.lastUpdateTime = lastUpdateTime
    }
    
}
