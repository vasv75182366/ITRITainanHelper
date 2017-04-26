//
//  Macros.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/23/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

public class Constants {
    
    // MARK: - List of MACROs
    
    static let MAIN_BAR_TITLE = "台南洽公小幫手"
    // put sqlite in app's Documents directory
    static let DB_PATH = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    static let DB_NAME = "tainan.sqlite"
    static let DB_FULLPATH = DB_PATH + DB_NAME
    
    static let SHOW_ADMINISTRATIVE_UNIT_BY_CATEGORY_ID = 1
    static let SHOW_ADMINISTRATIVE_UNIT_BY_KEYWORD = 2
    static let SHOW_ADMINISTRATIVE_UNIT_BY_OBJECT = 3
    static let REQUEST_ADMINISTRATIVE_UNIT = 1
    static let RESULT_CANCELED = 0
    static let SHOW_ADMINISTRATIVE_UNIT = 1
    static let RESULT_NAVIGATION = 2
    
    static let POSITION = "position"
    static let NAVIGATION_CODE = "navigationCode"
    static let MAIN_PAGE_SEARCH_DATA = "mainPageSearchData"
    
}
