//
//  Keyword.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

class Keyword {
    var keywordId: String!
    var keyword: String?
    var rank: Int64!
    var description: String?
    var createTime: Int64!
    var lastUpdateTime: Int64!
    
    init() {
        self.rank = 0
    }
    
    init(keywordId: String, keyword: String, rank: Int64, description: String, createTime: Int64, lastUpdateTime: Int64) {
        self.keywordId = keywordId
        self.keyword = keyword
        self.rank = rank
        self.description = description
        self.createTime = createTime
        self.lastUpdateTime = lastUpdateTime
    }
}
