//
//  DBCol.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/6/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation

class DBCol {
    
    // database columns
    static let TABLE_ADMINISTRATIVE_UNIT = "administrativeUnit"
    static let TABLE_ADMINISTRATIVE_UNIT_CATEGORY = "administrativeUnitCategory"
    static let TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY = "administrativeUnitInCategory"
    
    static let UNIT_ID = "unitId"
    static let PARENT_UNIT_ID = "parentUnitId"
    static let CATEGORY_ID = "categoryId"
    static let CATEGORY = "category"
    static let NAME = "name"
    static let FIELD_ID = "fieldId"
    static let X = "x"
    static let Y = "y"
    static let NEAR_BY_PATH_ID = "nearByPathId"
    static let TEL = "tel"
    static let FAX = "fax"
    static let EMAIL = "email"
    static let WEBSITE = "website"
    static let DESCRIPTION = "description"
    static let ICON_NAME = "iconName"
    static let KEYWORD = "keyword"
    static let IS_DELETE = "isDelete"
    static let CREATE_TIME = "createTime"
    static let LAST_UPDATE_TIME = "lastUpdateTime"
    
    static let TABLE_SEARCH_CACHE = "searchCache"
    static let SEARCH_KEYWORD = "searchKeyword"
    
    static let TABLE_KEYWORD = "keyword"
    static let KEYWORD_ID = "keywordId"
    static let RANK = "rank"
    
    static let TABLE_IN_KEYWORD = "inKeyword"
    static let ID = "id"
    
    // eDM table
    static let TABLE_EDM = "edm"
    static let EDM_ID = "edmId"
    static let EDM_NAME = "edmName"
    static let EDM_URL = "edmURL"
    static let EDM_IMAGE = "edmImage"
    static let EDM_END_DAY = "edmEndDay"
    
    // hot table
    static let TABLE_HOT = "hot"
    static let HOT_DATE = "hotDate"
    static let HOT_TITLE = "hotTitle"
    static let HOT_DESCRIPTION = "hotDescription"
    static let HOT_LINK = "hotLink"
    
    // mobile app table
    static let TABLE_MOBILEAPP = "mobileApp"
    static let APP_ID = "appId"
    static let APP_NAME = "appName"
    static let APP_URL = "appURL"
    static let APP_IMAGE = "appImage"
    
    // instruction table
    static let TABLE_INSTRUCTION = "instruction"
    static let INSTR_NAME = "name"
    static let INSTR_READ = "read"

}
