# ITRITainanHelper 

## Intro
* ITRI Project.
* The entire project(excluding the frameworks) is written in Swift 3.0
* this project is for **DEMO purpose ONLY**.
* *this DOC is written only for our project contributors.*

## Documentation

### API Doc for using class *DatabaseHelper*.
#### Initialization
use `init()` function to initialize your DatabaseHelper instance.
```jsx
let dbHelper = DatabaseHelper.init()
// name version: pass name into init()
let dbHelper2 = DatabaseHelper.init(name: "your_db.sqlite")
```
the default directory storing the SQLite databse would be application's document directory.

#### Creating Tables
Simple call either `create*TABLE_NAME*()` to create specific table or use `createAllTables()` to create all.
```jsx
// create all
dbHelper.createAllTables()
// create one
dbHelper.createEDMTable()
```
DatabaseHelper would finish creating the "defined" table for you.

#### Insert/Update rows to Tables
You should have to options to insert or update rows into our database.
1. use function such as: `insertOrUpdate*TableName*()`, pass in the data object needed for that db.
2. use function such as: `update*TableName*()` and pass in a JSON Object as the only parameter.
*p.s. for JSON Object data types, please refer to https://github.com/SwiftyJSON/SwiftyJSON*
```jsx
// insert a row
dbHelper.insertOrUpdateKeywordTable(id: 1, name: "two", read: 0)
// insert json obj, assume the JSON Object is called "json_obj"
dbHelper.updateMobileApp(jsonObj: json_obj)
```

#### Query
Should be relatively easy to use query:
```jsx
// example: mobileapp_array consists of MobileApp
let mobileapp_array = dbHelper.queryMobileAppTable()
```

#### Getting data
All data corresponding to table has its specific data type.
使用上面的 Query section 的介紹範例：
```jsx
// mobile app
for app in mobileapp_array {
	let app_data = app as! MobileApp
	print(app_data)
}
```

## Responsibility (for each main function)
### 最新訊息：對應到 NewsActivity
* 需要用到 RSS，需要在程式碼中使用 API 抓資料
* 抓完存起來，或者不存皆可
 
### 熱門活動：HotActivity
* 與最新消息相同，從 API 抓完資料後，使用 insertOrUpdateHotTable() 把資料存到 sqlite database。
* 實作：每一次進入熱門活動的介面，先呼叫給定的 API 得到資料後，存到 sqlite 裡面；再呼叫 queryHotTable() 函數把所有的熱門活動的資料抓出來顯示
 
### 市府設施：FacilityActivity
* 進入第一個 view controller 後：
1. 先呼叫 database helper 的 getFacilities() 函數，得到 AdministrativeUnitCategory 的 array
2. 根據自己設定的 6 個 layout 上主要元件的 position，從上一個步驟得到的 array 中取出你要的相對應的資料
3. 最後，在 6 個主要元件都各自設定 segue，能夠對應呼叫需要顯示的 view。此時，需要紀錄的是 categoryId，要帶入 categoryId 給 queryAdministrativeUnitByCategoryId() 抓出對應的所有 data
 
### 便民服務：QuickServiceActivity 
1. 呼叫 getSearchCache()，實作出 dropdown list，list 需要顯示的就是 getSearchCache 回傳的所有 data
2. 呼叫 database helper 的 getQuickServices() 函數，並且在 UITableView 上顯示所有 array 內的資料
 
### 局處導覽：DashboardActivity --> AdministrativeUnitCategoryActivity
1. 呼叫 getSearchCache()，實作出 dropdown list，list 需要顯示的就是 getSearchCache 回傳的所有 data
2. 呼叫 database helper 的 getAdministrativeCategories() 函數，並且在 UITableView 上顯示所有 array 內的資料
 
### Detail View Controllers for Facility/Service/Navigation View Controllers
* Facility / Navigation / Service View Controller: pass "categoryId" for the selected cell, and call "queryAdministrativeUnitByCategoryId(categoryId: String)" function, then display the return data in each cell.

 
### 搜尋活動：這部分就是根據 textview 上的字串去 search 整個 database，並且回傳
* searchCache() 會去紀錄曾經搜尋過的關鍵字，並且加入到 drop down list 中
* 主要就是 addSearchCache(), getSearchCache() 這兩個函數
 
### Edm：就是首頁可滑動區域那些照片，對應到 edm table
* 進入首頁後：
1. 呼叫 getEdm() 得到所有 edm 資料
2. 根據每一個 edm 資料，設定相對應的 image，然後紀錄他們的 edmUrl。
3. 點擊任何一個 edm image，要叫出能夠顯示對應的 edm url 的 view controller
 
### App 專區：
1. 進入 app 專區的 view 後，呼叫 database helper 的 queryMobileApp() 函數獲得所有的資料，從獲得的資料中可以得到對應欄位的 appIOSUrl
2. 此時，需要先去檢查 app 內部空間是否含有那些照片。若有照片了，請直接讀取照片。若沒有照片，請呼叫函數去下載(要使用 API，這部分我還找不到 url string，已詢問旭政)
 
## Others
PS. 便民服務、局處導覽、市府設施在進入抓資料前，會先呼叫 searchCache 相關函數獲得之前瀏覽紀錄

## First Launch
```jsx
//main layout
let defaults = UserDefaults.standard
let isAppLaunchBefore = defaults.bool(forKey: "isAppLaunchBefore")
if isAppLaunchBefore {
    /* normal layout */
} else {
    /* first launch layout */
    defaults.set(true, forKey: "isAppLaunchBefore")
}
```
```jsx
//message layout
let defaults = UserDefaults.standard
let isMessageLaunchBefore = defaults.bool(forKey: "isMessageLaunchBefore")
if isMessageLaunchBefore {
    /* normal layout */
} else {
    /* first launch layout */
    defaults.set(true, forKey: "isMessageLaunchBefore")
}
```
