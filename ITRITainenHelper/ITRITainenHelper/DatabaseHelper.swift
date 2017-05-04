//
//  DatabaseHelper.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/6/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation
import SQLite


class DatabaseHelper {
    
    var db_name: String!
    private static let DB_VERSION = 2
    public static let KEYWORD_ADMINISTRATIVE_CATEGORY_RANK = 1
    public static let KEYWORD_QUICK_SERVICE_RANK = 2
    public static let KEYWORD_FACILITY_RANK = 3
    
    // MARK: - expressions
    // table column reusable objects
    let x = Expression<Int64>(DBCol.X)
    let y = Expression<Int64>(DBCol.Y)
    let fieldId = Expression<String>(DBCol.FIELD_ID)
    let parentUnitId = Expression<String>(DBCol.PARENT_UNIT_ID)
    let tel = Expression<String>(DBCol.TEL)
    let fax = Expression<String>(DBCol.FAX)
    let email = Expression<String>(DBCol.EMAIL)
    let website = Expression<String>(DBCol.WEBSITE)
    let category = Expression<String>(DBCol.CATEGORY)
    let name = Expression<String>(DBCol.NAME)
    let description = Expression<String>(DBCol.DESCRIPTION)
    let nearByPathId = Expression<String>(DBCol.NEAR_BY_PATH_ID)
    let iconName = Expression<String>(DBCol.ICON_NAME)
    let createTime = Expression<Int64>(DBCol.CREATE_TIME)
    let lastUpdateTime = Expression<Int64>(DBCol.LAST_UPDATE_TIME)
    let keyword = Expression<String>(DBCol.KEYWORD)
    let unitId = Expression<String>(DBCol.UNIT_ID)
    let categoryId = Expression<String>(DBCol.CATEGORY_ID)
    let edmId = Expression<String>(DBCol.EDM_ID)
    let edmName = Expression<String>(DBCol.EDM_NAME)
    let edmURL = Expression<String>(DBCol.EDM_URL)
    let edmImage = Expression<String>(DBCol.EDM_IMAGE)
    let edmEndDay = Expression<String>(DBCol.EDM_END_DAY)
    let id = Expression<Int64>("id")
    let stringId = Expression<String>("id")
    let hotDate = Expression<String>(DBCol.HOT_DATE)
    let hotTitle = Expression<String>(DBCol.HOT_TITLE)
    let hotDescription = Expression<String>(DBCol.HOT_DESCRIPTION)
    let hotLink = Expression<String>(DBCol.HOT_LINK)
    let isDelete = Expression<Int64>(DBCol.IS_DELETE)
    let keywordId = Expression<String>(DBCol.KEYWORD_ID)
    let read = Expression<Int64>("read")
    let rank = Expression<Int64>(DBCol.RANK)
    let appId = Expression<String>(DBCol.APP_ID)
    let appName = Expression<String>(DBCol.APP_NAME)
    let appURL = Expression<String>(DBCol.APP_URL)
    let appImage = Expression<String>(DBCol.APP_IMAGE)
    let sequence = Expression<String>("sequence")

    // initializer
    init() {
        self.db_name = Constants.DB_NAME
    }
    
    func createDB() -> Void {
        createAllTables()
    }
    
    
    // MARK: - create tables

    func createAllTables() -> Void {
        createAdministrativeUnitTable()
        createAdministrativeUnitCategoryTable()
        createAdministrativeUnitInCategoryTable()
        createEDMTable()
        createHotTable()
        createInKeywordTable()
        createInstructionTable()
        createKeywordTable()
        createMappingKeywordTable()
        createMobileAppTable()
    }
    
    // create administrativeUnit table
    func createAdministrativeUnitTable() -> Void {
        do {
            // create table
            let db = try Connection(Constants.DB_FULLPATH)
            let administrativeUnitTable = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            
            try db.run(administrativeUnitTable.create(ifNotExists: true) { t in
                t.column(self.x)
                t.column(self.y)
                t.column(self.fieldId)
                t.column(self.unitId)
                t.column(self.parentUnitId)
                t.column(self.name)
                t.column(self.tel)
                t.column(self.fax)
                t.column(self.email)
                t.column(self.website)
                t.column(self.description)
                t.column(self.iconName)
                t.column(self.createTime)
                t.column(self.lastUpdateTime)
                t.column(self.nearByPathId)
                t.column(self.keyword)
            })
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT) succeeded.")
        } catch  {
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT) error.")
        }

    }
    
    // create administrativeUnitCategory Table
    func createAdministrativeUnitCategoryTable() -> Void {
        
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let administrativeUnitCategory = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)

            try db.run(administrativeUnitCategory.create(ifNotExists: true) { t in
                t.column(self.categoryId)
                t.column(self.name)
                t.column(self.description)
                t.column(self.iconName)
                t.column(self.createTime)
                t.column(self.lastUpdateTime)
                t.column(self.keyword)
            })
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY) succeeded.")
        } catch  {
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY) failed.")
        }
    }
    
    // create administrativeUnitInCategory Table
    func createAdministrativeUnitInCategoryTable() -> Void {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let administrativeUnitInCategory = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY)

            try db.run(administrativeUnitInCategory.create(ifNotExists: true) { t in
                t.column(self.unitId)
                t.column(self.categoryId)
                t.column(self.lastUpdateTime)
            })
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY) succeeded.")
        } catch  {
            print("create \(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY) fail.")
        }
    }
    
    // create Edm Table
    func createEDMTable() -> Void {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let edmTable = Table(DBCol.TABLE_EDM)
            try db.run(edmTable.create(ifNotExists: true) { t in
                t.column(self.edmId)
                t.column(self.edmName)
                t.column(self.edmURL)
                t.column(self.edmImage)
                t.column(self.edmEndDay)
                t.column(self.lastUpdateTime)
            })
            print("create \(DBCol.TABLE_EDM) succeeded.")
        } catch {
            print("create \(DBCol.TABLE_EDM) fail.")
        }
    }
    
    // create Hot Table
    func createHotTable() -> Void {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let hotTable = Table(DBCol.TABLE_HOT)
            try db.run(hotTable.create(ifNotExists: true) { t in
                t.column(self.id, primaryKey: .autoincrement)
                t.column(self.hotDate)
                t.column(self.hotTitle)
                t.column(self.hotDescription)
                t.column(self.hotLink)
                t.column(self.isDelete, defaultValue: 0)
            })
            print("create Hot Table succeeded.")
        } catch {
            print("create Hot Table fail.")
        }
    }
    
    // create InKeyword Table
    func createInKeywordTable() -> Void {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let inKeywordTable = Table(DBCol.TABLE_IN_KEYWORD)

            try db.run(inKeywordTable.create(ifNotExists: true) { t in
                t.column(self.stringId)
                t.column(self.keywordId)
                t.column(self.lastUpdateTime)
            })
            print("create inKeyword Table succeeded.")
        } catch {
            print("create inKeyword Table fail.")
        }
    }
    
    // create instruction Table
    func createInstructionTable() -> Void {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let instructionTable = Table(DBCol.TABLE_INSTRUCTION)
            try db.run(instructionTable.create(ifNotExists: true) { t in
                t.column(self.id, unique: true)
                t.column(self.name)
                t.column(self.read, defaultValue: 0)
            })
            print("create instruction Table succeeded.")
        } catch {
            print("create instruction Table fail.")
        }
        
    }
    
    // create keyword table
    func createKeywordTable() -> Void {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let keywordTable = Table(DBCol.TABLE_KEYWORD)
            try db.run(keywordTable.create(ifNotExists: true) { t in
                t.column(self.keywordId)
                t.column(self.keyword)
                t.column(self.rank)
                t.column(self.description)
                t.column(self.createTime)
                t.column(self.lastUpdateTime)
            })
            print("create Keyword Table succeeded.")
        } catch {
            print("create Keyword Table fail.")
        }
    }
    
    // create mapping keyword table
    func createMappingKeywordTable() -> Void {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let mappingKeywordTable = Table("mappingKeyword")
            try db.run(mappingKeywordTable.create(ifNotExists: true) { t in
                t.column(self.unitId)
                t.column(self.keyword)
            })
            print("create mapping keyword table succeeded.")
        } catch {
            print("create mapping keyword table failed.")
        }
    }
    
    // create mobile app table
    func createMobileAppTable() -> Void {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let mobileAppTable = Table(DBCol.TABLE_MOBILEAPP)
            try db.run(mobileAppTable.create(ifNotExists: true) { t in
                t.column(self.appId)
                t.column(self.appName)
                t.column(self.appURL)
                t.column(self.appImage)
                t.column(self.lastUpdateTime)
            })
            print("create mobile app Table succeeded.")
        } catch {
            print("create mobile app Table fail.")
        }
    }
    
    
    // MARK: - insert or update
    // cannot insert into this table
    func insertOrUpdateAdministrativeUnitTable(x: Int64, y: Int64, fieldId: String, unitId: String, parentUnitId: String, name: String, tel: String, fax: String, email: String, website: String, description: String, iconName: String, createTime: Int64, lastUpdateTime: Int64, nearByPathId: String, keyword: String) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            
            // try insert/replace
            try db.run(table.insert(or: .replace, self.x <- x, self.y <- y, self.fieldId <- fieldId, self.unitId <- unitId, self.parentUnitId <- parentUnitId, self.name <- name, self.tel <- tel, self.fax <- fax, self.email <- email, self.website <- website, self.description <- description, self.iconName <- iconName, self.createTime <- createTime, self.lastUpdateTime <- lastUpdateTime, self.nearByPathId <- nearByPathId, self.keyword <- keyword))
            
            print("insert/update administrative unit table succeeded.")
            return true
        } catch _ {
            print("insert/update administrative unit table error.")
            return false
        }
    }
    
    
    func insertOrUpdateAdministrativeUnitCategory(categoryId: String, name: String, description: String, iconName: String, createTime: Int64, lastUpdateTime: Int64, keyword: String) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)
            
            // try insert/replace the row
            try db.run(table.insert(or: .replace, self.categoryId <- categoryId, self.name <- name, self.description <- description, self.iconName <- iconName, self.createTime <- createTime, self.lastUpdateTime <- lastUpdateTime, self.keyword <- keyword))
            
            print("insert/update administrative unit category table succeeded.")
            return true
        } catch _ {
            print("insert/update administrative unit category table error.")
            return false
        }
    }
    
    func insertOrUpdateAdministrativeUnitInCategory(unitId: String, categoryId: String, lastUpdateTime: Int64) -> Bool{
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY)
            
            // try insert/replace
            try db.run(table.insert(or: .replace, self.unitId <- unitId, self.categoryId <- categoryId, self.lastUpdateTime <- lastUpdateTime))
            
            print("insert/update administrative unit in category table succeeded.")
            return true
        } catch _ {
            print("insert/update administrative unit in category table error.")
            return false
        }
    }
    
    func insertOrUpdateEdmTable(edmId: String, edmName: String, edmURL: String, edmImage: String, edmEndDay: String, lastUpdateTime: Int64) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_EDM)
            
            // try insert/replace
            try db.run(table.insert(or: .replace, self.edmId <- edmId, self.edmName <- edmName, self.edmURL <- edmURL, self.edmImage <- edmImage, self.edmEndDay <- edmEndDay, self.lastUpdateTime <- lastUpdateTime))
            
            print("insert/update edm table succeeded.")
            return true
        } catch _ {
            print("insert/update edm table error.")
            return false
        }
    }
    
    func insertOrUpdateHotTable(id: Int64, hotDate: String, hotTitle: String, hotDescription: String, hotLink: String, isDelete: Int64) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_HOT)
            
            // try insert/update
            try db.run(table.insert(or: .replace, self.id <- id, self.hotDate <- hotDate, self.hotTitle <- hotTitle, self.hotDescription <- hotDescription, self.hotLink <- hotLink, self.isDelete <- isDelete))
            
            print("insert/update hot table error.")
            return true
        } catch _ {
            print("insert/update hot table error.")
            return false
        }
    }
    
    func insertOrUpdateInKeywordTable(id : String, keywordId: String, lastUpdateTime: Int64) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_IN_KEYWORD)
            
            // try insert/replace
            try db.run(table.insert(or: .replace, self.stringId <- id, self.keywordId <- keywordId, self.lastUpdateTime <- lastUpdateTime))
            
            print("insert/update in keyword table succeeded.")
            return true
        } catch _ {
            print("insert/update in keyword table error.")
            return false
        }
    }
    
    func insertOrUpdateInstructionTable(id: Int64, name: String, read: Int64) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_INSTRUCTION)
            
            // try insert/replace
            try db.run(table.insert(or: .replace, self.id <- id, self.name <- name, self.read <- read))
            
            print("insert/update instruction table succeeded.")
            return true
        } catch _ {
            print("insert/update instruction table error.")
            return false
        }
    }
    
    func insertOrUpdateKeywordTable(keywordId: String, keyword: String, rank: Int64, description: String, createTime: Int64, lastUpdateTime: Int64) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_KEYWORD)
            
            // try insert/replace
            try db.run(table.insert(or: .replace, self.keywordId <- keywordId, self.keyword <- keyword, self.rank <- rank, self.description <- description, self.createTime <- createTime, self.lastUpdateTime <- lastUpdateTime))
            
            print("insert/update keyword table succeeded.")
            return true
        } catch _ {
            print("insert/update keyword table error.")
            return false
        }
    }
    
    func insertOrUpdateMappingKeywordTable(unitId: String, keyword: String) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table("mappingKeyword")
            
            // try insert/replace
            try db.run(table.insert(or: .replace, self.unitId <- unitId, self.keyword <- keyword))
            
            print("insert/update mapping keyword table succeeded.")
            return true
        } catch _ {
            print("insert/update mapping keyword table error.")
        }
        return false
    }
    
    func insertOrUpdateMobileAppTable(appId: String, appName: String, appURL: String, appImage: String, lastUpdateTime: Int64) -> Bool {
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_MOBILEAPP)
            
            // try insert/replace
            try db.run(table.insert(or: .replace, self.appId <- appId, self.appName <- appName, self.appURL <- appURL, self.appImage <- appImage, self.lastUpdateTime <- lastUpdateTime))
            
            print("insert/update mobile app table succeeded.")
            return true
        } catch _ {
            print("insert/update mobile app table error.")
            return false
        }
    }
    
    
    
    // MARK: - query functions
    func queryAdministrativeUnitTable() -> NSMutableArray {
        let administrativeUnits = NSMutableArray()

        do {
            let administrative_table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            let db = try Connection(Constants.DB_FULLPATH)

            for admin_unit in try db.prepare(administrative_table) {
                
                let adminUnit = AdministrativeUnit(x: admin_unit[self.x], y: admin_unit[self.y], fieldId: admin_unit[self.fieldId], unitId: admin_unit[self.unitId], parentUnitId: admin_unit[self.parentUnitId], name: admin_unit[self.name], tel: admin_unit[self.tel], fax: admin_unit[self.fax], email: admin_unit[self.email], website: admin_unit[self.website], description: admin_unit[self.description], iconName: admin_unit[self.iconName], createTime: admin_unit[self.createTime], lastUpdateTime: admin_unit[self.lastUpdateTime], nearByPathId: admin_unit[self.nearByPathId], keyword: admin_unit[self.keyword])
                administrativeUnits.add(adminUnit)
//                print("x: \(admin_unit[self.x]), y: \(admin_unit[self.y]), fieldId: \(admin_unit[self.fieldId]), unitId: \(admin_unit[self.unitId]), parentUnitId: \(admin_unit[self.parentUnitId]), name: \(admin_unit[self.name]), tel: \(admin_unit[self.tel]), fax: \(admin_unit[self.fax]), email: \(admin_unit[self.email]), website: \(admin_unit[self.website]), description: \(admin_unit[self.description]), iconName: \(admin_unit[self.iconName]), createTime: \(admin_unit[self.createTime]), lastUpdateTime: \(admin_unit[self.lastUpdateTime]), nearByPathId: \(admin_unit[self.nearByPathId]), keyword: \(admin_unit[self.keyword])")
            }
            print("query administrative unit table succeed.")
        } catch _ {
            print("query administrative unit table fail.")
        }
        return administrativeUnits
    }
    
    func queryAdministrativeUnitCategoryTable() -> NSMutableArray {
        let administrativeUnitCategories = NSMutableArray()
        do {
            let administrativeUnitCategoryTable = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)
            let db = try Connection(Constants.DB_FULLPATH)
            for categories in try db.prepare(administrativeUnitCategoryTable) {
                let adminUnitCategory = AdministrativeUnitCategory(categoryId: categories[self.categoryId], name: categories[self.name], description: categories[self.description], iconName: categories[self.iconName], createTime: categories[self.createTime], lastUpdateTime: categories[self.lastUpdateTime], keyword: categories[self.keyword])
                administrativeUnitCategories.add(adminUnitCategory)
            }
            print("query administrative unit category table succeed.")
        } catch _ {
            print("query administrative unit category table fail.")
        }
        return administrativeUnitCategories
    }
    
    func queryAdministrativeUnitInCategoryTable() -> NSMutableArray {
        let unitInCategories = NSMutableArray()
        do {
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_IN_CATEGORY)
            let db = try Connection(Constants.DB_FULLPATH)
            for rows in try db.prepare(table) {
                let data = AdministrativeUnitInCategory(unitId: rows[self.unitId], categoryId: rows[self.categoryId], lastUpdateTime: rows[self.lastUpdateTime])
                unitInCategories.add(data)
            }
            print("query administrative unit in category table succeed.")
        } catch _ {
            print("query administrative unit in category table fail.")
        }
        return unitInCategories
    }
    
    func queryEdmTable() -> NSMutableArray {
        let edms = NSMutableArray()
        do {
            let table = Table(DBCol.TABLE_EDM)
            let db = try Connection(Constants.DB_FULLPATH)
            for rows in try db.prepare(table) {
                let data = Edm(edmId: rows[self.edmId], edmName: rows[self.edmName], edmURL: rows[self.edmURL], edmImage: rows[self.edmImage], edmEndDay: rows[self.edmEndDay], lastUpdateTime: rows[self.lastUpdateTime])
                edms.add(data)
            }
            print("query edm table succeed.")
        } catch _ {
            print("query edm table fail.")
        }
        return edms
    }
    
    func queryHotTable() -> NSMutableArray {
        let hots = NSMutableArray()
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_HOT)
            for rows in try db.prepare(table) {
                let data = HotItem(id: rows[self.id], hotDate: rows[self.hotDate], hotTitle: rows[self.hotTitle], hotDescription: rows[self.hotDescription], hotLink: rows[self.hotLink], isDelete: rows[self.isDelete])
                hots.add(data)
            }
            print("query hot table succeed.")
        } catch _ {
            print("query hot table fail.")
        }
        return hots
    }
    
    func queryInKeywordTable() -> NSMutableArray {
        let inKeywords = NSMutableArray()
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_IN_KEYWORD)
            for rows in try db.prepare(table) {
                let data = InKeywords(id: String(rows[self.stringId]), keywordId: rows[self.keywordId], lastUpdateTime: rows[self.lastUpdateTime])
                inKeywords.add(data)
            }
            print("query in keyword table succeed.")
        } catch _ {
            print("query in keyword table fail.")
        }
        return inKeywords
    }
    
    func queryInstructionTable() -> NSMutableArray {
        let instructions = NSMutableArray()
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_INSTRUCTION)
            for rows in try db.prepare(table) {
                let data = InstructionItem(id: rows[self.id], name: rows[self.name], read: rows[self.read])
                instructions.add(data)
            }
            print("query instruction table succeed.")
        } catch _ {
            print("query instruction table fail.")
        }
        return instructions
    }
    
    func queryKeywordTable() -> NSMutableArray {
        let keywords = NSMutableArray()
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_KEYWORD)
            for rows in try db.prepare(table) {
                let data = Keyword(keywordId: rows[self.keywordId], keyword: rows[self.keyword], rank: rows[self.rank], description: rows[self.description], createTime: rows[self.createTime], lastUpdateTime: rows[self.lastUpdateTime])
                keywords.add(data)
            }
            print("query keyword table succeed.")
        } catch _ {
            print("query keyword table fail.")
        }
        return keywords
    }
    
    func queryMappingKeywordTable() -> NSMutableArray {
        let mappings = NSMutableArray()
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table("mappingKeyword")
            for rows in try db.prepare(table) {
                let data = MappingKeyword(unitId: rows[self.unitId], keyword: rows[self.keyword])
                mappings.add(data)
            }
            print("query mapping keyword table succeed.")
        } catch _ {
            print("query mapping keyword table fail.")
        }
        return mappings
    }
    
    func queryMobileAppTable() -> NSMutableArray {
        let apps = NSMutableArray()
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_MOBILEAPP)
            for rows in try db.prepare(table) {
                let data = MobileApps(appId: rows[self.appId], appName: rows[self.appName], appURL: rows[self.appURL], appImage: rows[self.appImage], lastUpdateTime: rows[self.lastUpdateTime])
                apps.add(data)
            }
            print("query mobileapp table succeed.")
        } catch _ {
            print("query mobileapp table fail.")
        }
        return apps
    }
    
    
}
