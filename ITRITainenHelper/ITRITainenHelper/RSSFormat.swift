//
//  RSSFormat.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/10.
//  Copyright © 2017年 uscc. All rights reserved.
//

import Foundation

class RSSFormat {
    var title: String!
    var pubDate: Date?
    var link: String!
    
    init(title: String!, pubDate: Date?, link: String!) {
        self.title = title
        self.pubDate = pubDate
        self.link = link
    }
    
}
