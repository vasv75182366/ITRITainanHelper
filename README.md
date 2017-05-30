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
*p.s. for JSON Object data types, please refer to https://github.com/SwiftyJSON/SwiftyJSON#swiftyjson*
```jsx
// insert a row
dbHelper.insertOrUpdateKeywordTable(id: 1, name: "two", read: 0)
// insert json obj, assume the JSON Object is called "json_obj"
dbHelper.updateMobileApp(jsonObj: json_obj)
```

#### Query
Should be relatively easy to use query:
```jsx
// example:
dbHelper.queryMobileAppTable()
```
