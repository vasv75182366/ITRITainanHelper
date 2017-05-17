//
//  DatabaseHelper.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/6/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import Foundation
import SQLite
import SwiftyJSON


class DatabaseHelper {
    
    var db_name: String!
    private static let DB_VERSION = 2
    public static let KEYWORD_ADMINISTRATIVE_CATEGORY_RANK = 1
    public static let KEYWORD_QUICK_SERVICE_RANK = 2
    public static let KEYWORD_FACILITY_RANK = 3
    

    // initializer
    init() {
        self.db_name = Constants.DB_NAME
    }
    
    init(name: String) {
        self.db_name = name
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
                t.column(DBColExpressions.x)
                t.column(DBColExpressions.y)
                t.column(DBColExpressions.fieldId)
                t.column(DBColExpressions.unitId)
                t.column(DBColExpressions.parentUnitId)
                t.column(DBColExpressions.name)
                t.column(DBColExpressions.tel)
                t.column(DBColExpressions.fax)
                t.column(DBColExpressions.email)
                t.column(DBColExpressions.website)
                t.column(DBColExpressions.description)
                t.column(DBColExpressions.iconName)
                t.column(DBColExpressions.createTime)
                t.column(DBColExpressions.lastUpdateTime)
                t.column(DBColExpressions.nearByPathId)
                t.column(DBColExpressions.keyword)
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
                t.column(DBColExpressions.categoryId)
                t.column(DBColExpressions.name)
                t.column(DBColExpressions.description)
                t.column(DBColExpressions.iconName)
                t.column(DBColExpressions.createTime)
                t.column(DBColExpressions.lastUpdateTime)
                t.column(DBColExpressions.keyword)
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
                t.column(DBColExpressions.unitId)
                t.column(DBColExpressions.categoryId)
                t.column(DBColExpressions.lastUpdateTime)
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
                t.column(DBColExpressions.edmId)
                t.column(DBColExpressions.edmName)
                t.column(DBColExpressions.edmURL)
                t.column(DBColExpressions.edmImage)
                t.column(DBColExpressions.edmEndDay)
                t.column(DBColExpressions.lastUpdateTime)
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
                t.column(DBColExpressions.id, primaryKey: .autoincrement)
                t.column(DBColExpressions.hotDate)
                t.column(DBColExpressions.hotTitle)
                t.column(DBColExpressions.hotDescription)
                t.column(DBColExpressions.hotLink)
                t.column(DBColExpressions.isDelete, defaultValue: 0)
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
                t.column(DBColExpressions.stringId)
                t.column(DBColExpressions.keywordId)
                t.column(DBColExpressions.lastUpdateTime)
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
                t.column(DBColExpressions.id, unique: true)
                t.column(DBColExpressions.name)
                t.column(DBColExpressions.read, defaultValue: 0)
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
                t.column(DBColExpressions.keywordId)
                t.column(DBColExpressions.keyword)
                t.column(DBColExpressions.rank)
                t.column(DBColExpressions.description)
                t.column(DBColExpressions.createTime)
                t.column(DBColExpressions.lastUpdateTime)
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
                t.column(DBColExpressions.unitId)
                t.column(DBColExpressions.keyword)
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
                t.column(DBColExpressions.appId)
                t.column(DBColExpressions.appName)
                t.column(DBColExpressions.appURL)
                t.column(DBColExpressions.appImage)
                t.column(DBColExpressions.lastUpdateTime)
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
            try db.run(table.insert(or: .replace, DBColExpressions.x <- x, DBColExpressions.y <- y, DBColExpressions.fieldId <- fieldId, DBColExpressions.unitId <- unitId, DBColExpressions.parentUnitId <- parentUnitId, DBColExpressions.name <- name, DBColExpressions.tel <- tel, DBColExpressions.fax <- fax, DBColExpressions.email <- email, DBColExpressions.website <- website, DBColExpressions.description <- description, DBColExpressions.iconName <- iconName, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime, DBColExpressions.nearByPathId <- nearByPathId, DBColExpressions.keyword <- keyword))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.categoryId <- categoryId, DBColExpressions.name <- name, DBColExpressions.description <- description, DBColExpressions.iconName <- iconName, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime, DBColExpressions.keyword <- keyword))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.unitId <- unitId, DBColExpressions.categoryId <- categoryId, DBColExpressions.lastUpdateTime <- lastUpdateTime))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.edmId <- edmId, DBColExpressions.edmName <- edmName, DBColExpressions.edmURL <- edmURL, DBColExpressions.edmImage <- edmImage, DBColExpressions.edmEndDay <- edmEndDay, DBColExpressions.lastUpdateTime <- lastUpdateTime))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.id <- id, DBColExpressions.hotDate <- hotDate, DBColExpressions.hotTitle <- hotTitle, DBColExpressions.hotDescription <- hotDescription, DBColExpressions.hotLink <- hotLink, DBColExpressions.isDelete <- isDelete))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.stringId <- id, DBColExpressions.keywordId <- keywordId, DBColExpressions.lastUpdateTime <- lastUpdateTime))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.id <- id, DBColExpressions.name <- name, DBColExpressions.read <- read))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.keywordId <- keywordId, DBColExpressions.keyword <- keyword, DBColExpressions.rank <- rank, DBColExpressions.description <- description, DBColExpressions.createTime <- createTime, DBColExpressions.lastUpdateTime <- lastUpdateTime))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.unitId <- unitId, DBColExpressions.keyword <- keyword))
            
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
            try db.run(table.insert(or: .replace, DBColExpressions.appId <- appId, DBColExpressions.appName <- appName, DBColExpressions.appURL <- appURL, DBColExpressions.appImage <- appImage, DBColExpressions.lastUpdateTime <- lastUpdateTime))
            
            print("insert/update mobile app table succeeded.")
            return true
        } catch _ {
            print("insert/update mobile app table error.")
            return false
        }
    }
    
    
    
    // MARK: - new update and insert function for 
    
    
    
    // MARK: - query functions
    func queryAdministrativeUnitTable() -> NSMutableArray {
        let administrativeUnits = NSMutableArray()

        do {
            let administrative_table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            let db = try Connection(Constants.DB_FULLPATH)

            for admin_unit in try db.prepare(administrative_table) {
                
                let adminUnit = AdministrativeUnit(x: admin_unit[DBColExpressions.x], y: admin_unit[DBColExpressions.y], fieldId: admin_unit[DBColExpressions.fieldId], unitId: admin_unit[DBColExpressions.unitId], parentUnitId: admin_unit[DBColExpressions.parentUnitId], name: admin_unit[DBColExpressions.name], tel: admin_unit[DBColExpressions.tel], fax: admin_unit[DBColExpressions.fax], email: admin_unit[DBColExpressions.email], website: admin_unit[DBColExpressions.website], description: admin_unit[DBColExpressions.description], iconName: admin_unit[DBColExpressions.iconName], createTime: admin_unit[DBColExpressions.createTime], lastUpdateTime: admin_unit[DBColExpressions.lastUpdateTime], nearByPathId: admin_unit[DBColExpressions.nearByPathId], keyword: admin_unit[DBColExpressions.keyword])
                administrativeUnits.add(adminUnit)
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
                let adminUnitCategory = AdministrativeUnitCategory(categoryId: categories[DBColExpressions.categoryId], name: categories[DBColExpressions.name], description: categories[DBColExpressions.description], iconName: categories[DBColExpressions.iconName], createTime: categories[DBColExpressions.createTime], lastUpdateTime: categories[DBColExpressions.lastUpdateTime], keyword: categories[DBColExpressions.keyword])
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
                let data = AdministrativeUnitInCategory(unitId: rows[DBColExpressions.unitId], categoryId: rows[DBColExpressions.categoryId], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
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
                let data = Edm(edmId: rows[DBColExpressions.edmId], edmName: rows[DBColExpressions.edmName], edmURL: rows[DBColExpressions.edmURL], edmImage: rows[DBColExpressions.edmImage], edmEndDay: rows[DBColExpressions.edmEndDay], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
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
                let data = HotItem(id: rows[DBColExpressions.id], hotDate: rows[DBColExpressions.hotDate], hotTitle: rows[DBColExpressions.hotTitle], hotDescription: rows[DBColExpressions.hotDescription], hotLink: rows[DBColExpressions.hotLink], isDelete: rows[DBColExpressions.isDelete])
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
                let data = InKeywords(id: String(rows[DBColExpressions.stringId]), keywordId: rows[DBColExpressions.keywordId], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
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
                let data = InstructionItem(id: rows[DBColExpressions.id], name: rows[DBColExpressions.name], read: rows[DBColExpressions.read])
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
                let data = Keyword(keywordId: rows[DBColExpressions.keywordId], keyword: rows[DBColExpressions.keyword], rank: rows[DBColExpressions.rank], description: rows[DBColExpressions.description], createTime: rows[DBColExpressions.createTime], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
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
                let data = MappingKeyword(unitId: rows[DBColExpressions.unitId], keyword: rows[DBColExpressions.keyword])
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
                let data = MobileApps(appId: rows[DBColExpressions.appId], appName: rows[DBColExpressions.appName], appURL: rows[DBColExpressions.appURL], appImage: rows[DBColExpressions.appImage], lastUpdateTime: rows[DBColExpressions.lastUpdateTime])
                apps.add(data)
            }
            print("query mobileapp table succeed.")
        } catch _ {
            print("query mobileapp table fail.")
        }
        return apps
    }
    
    
    func getLastUpdateTime(tableName: String) -> Int64 {
        var lastTime = Int64(0)
        do {
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(tableName)
            // query "lastUpdateTime" column for the designated table: SELECT lastUpdateTime FROM tableName ORDER BY lastUpdateTime DESC LIMIT 1
            let query = table.select(DBColExpressions.lastUpdateTime).order(DBColExpressions.lastUpdateTime.desc).limit(1)
            let count = 1
            // get first row
            for times in try db.prepare(query) {
                if (count == 1) {
                    lastTime = times[DBColExpressions.lastUpdateTime]
                    break
                }
            }
//            let times = try db.pluck(query)
        } catch _ {
            print("query lastUpdateTime error.")
        }
        return lastTime
    }
    
    
    
    // MARK: - sync tables
    func updateAdministrativeUnit(jsonObj: Any) {
        do {
            // pluck a row: if there is data
            let db = try Connection(Constants.DB_FULLPATH)
            let table = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT)
            
        } catch _ {
            print("update administrative unit table error.")
        }
    }
    
    
    // administrative unit
    func syncAdministrativeUnitTable(jsonObj: JSON) {
        let result = jsonObj["result"].intValue;
        // print result
        print(result)
        if (result == 0) {
            let dataArray = jsonObj["data"];
            for dict in dataArray {
                // call new insert function by passing json object
                updateAdministrativeUnit(jsonObj: dict)
            }
        }
    }
    
    
}
