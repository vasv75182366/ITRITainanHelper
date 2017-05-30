//
//  MobileApps.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

class MobileApps {
    var appId: String!
    var appName: String?
    var appIOSUrl: String?
    var appImage: String?
    var lastUpdateTime: Int64!
    
    init() {
        
    }
    
    init(appId: String, appName: String, appIOSUrl: String, appImage: String, lastUpdateTime: Int64) {
        self.appId = appId
        self.appName = appName
        self.appImage = appImage
        self.appIOSUrl = appIOSUrl
        self.lastUpdateTime = lastUpdateTime
    }
    
}
