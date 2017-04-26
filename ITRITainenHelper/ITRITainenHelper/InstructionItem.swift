//
//  InstructionItem.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/20/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation


class InstructionItem {
    var id: Int64!
    var name: String?
    var read: Int64!
    
    init() {
        self.read = 0
    }
    
    init(id: Int64, name: String, read: Int64) {
        self.id = id
        self.name = name
        self.read = read
    }
    
}
