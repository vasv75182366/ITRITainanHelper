//
//  ActivityRSSFormat.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/11.
//  Copyright © 2017年 uscc. All rights reserved.
//

import Foundation

class ActivityRSSFormat{
    var title: String!
    var pubDate: Date?
    var link: String!
    
    init(title: String!, pubDate: Date?, link: String!){
        self.title = title
        self.pubDate = pubDate
        self.link = link
    }
}
