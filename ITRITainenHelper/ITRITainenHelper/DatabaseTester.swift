//
//  DatabaseTester.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/23/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation


class DatabaseTester {
    init() {
        let db = DatabaseHelper.init()
        // create all tables
        db.createDB()
    }
    
}
