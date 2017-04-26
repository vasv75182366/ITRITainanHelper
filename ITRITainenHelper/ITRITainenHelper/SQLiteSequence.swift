//
//  SQLiteSequence.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation


class SQLiteSequence {
    var name: String!
    var seq: String!
    
    init() {
        
    }
    
    init(name: String, seq: String) {
        self.name = name
        self.seq = seq
    }
}
