//
//  DBColExpressions.swift
//  ITRITainenHelper
//
//  Created by Oslo on 5/17/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation
import SQLite

class DBColExpressions {
    // MARK: - expressions
    // table column reusable objects
    static let x = Expression<Int64>(DBCol.X)
    static let y = Expression<Int64>(DBCol.Y)
    static let fieldId = Expression<String>(DBCol.FIELD_ID)
    static let parentUnitId = Expression<String>(DBCol.PARENT_UNIT_ID)
    static let tel = Expression<String>(DBCol.TEL)
    static let fax = Expression<String>(DBCol.FAX)
    static let email = Expression<String>(DBCol.EMAIL)
    static let website = Expression<String>(DBCol.WEBSITE)
    static let category = Expression<String>(DBCol.CATEGORY)
    static let name = Expression<String>(DBCol.NAME)
    static let description = Expression<String>(DBCol.DESCRIPTION)
    static let nearByPathId = Expression<String>(DBCol.NEAR_BY_PATH_ID)
    static let iconName = Expression<String>(DBCol.ICON_NAME)
    static let createTime = Expression<Int64>(DBCol.CREATE_TIME)
    static let lastUpdateTime = Expression<Int64>(DBCol.LAST_UPDATE_TIME)
    static let keyword = Expression<String>(DBCol.KEYWORD)
    static let unitId = Expression<String>(DBCol.UNIT_ID)
    static let categoryId = Expression<String>(DBCol.CATEGORY_ID)
    static let edmId = Expression<String>(DBCol.EDM_ID)
    static let edmName = Expression<String>(DBCol.EDM_NAME)
    static let edmURL = Expression<String>(DBCol.EDM_URL)
    static let edmImage = Expression<String>(DBCol.EDM_IMAGE)
    static let edmEndDay = Expression<String>(DBCol.EDM_END_DAY)
    static let id = Expression<Int64>("id")
    static let stringId = Expression<String>("id")
    static let hotDate = Expression<String>(DBCol.HOT_DATE)
    static let hotTitle = Expression<String>(DBCol.HOT_TITLE)
    static let hotDescription = Expression<String>(DBCol.HOT_DESCRIPTION)
    static let hotLink = Expression<String>(DBCol.HOT_LINK)
    static let isDelete = Expression<Int64>(DBCol.IS_DELETE)
    static let keywordId = Expression<String>(DBCol.KEYWORD_ID)
    static let read = Expression<Int64>("read")
    static let rank = Expression<Int64>(DBCol.RANK)
    static let appId = Expression<String>(DBCol.APP_ID)
    static let appName = Expression<String>(DBCol.APP_NAME)
    static let appURL = Expression<String>(DBCol.APP_URL)
    static let appImage = Expression<String>(DBCol.APP_IMAGE)
    static let sequence = Expression<String>("sequence")
    static let appIOSUrl = Expression<String>(DBCol.APP_IOSURL)
    static let searchKeyword = Expression<String>(DBCol.SEARCH_KEYWORD)
    
    // special case for "tainan.sqlite"'s "InKeyword" Table
    static let wrongLastUpdateTime = Expression<Int64>("lastUpdateTIme")
    
}
