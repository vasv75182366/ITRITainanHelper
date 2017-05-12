//
//  ViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/16/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import SQLite


class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - variables
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    // activity view: has to add image as bg
    @IBOutlet weak var activityView: UIView!
    var activityImageView =  UIImageView()
    @IBOutlet weak var functionCollection: UICollectionView!
    weak var navigationBar: UINavigationBar!
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    var rightActivityButton =  UIButton()
    var leftActivityButton = UIButton()
    
    var cellBgImage: UIImage!
    var titleCombineView: UIView!
    var checkFunction: Int = 0
    
    // image arrays
    var logoImage: [UIImage] = [
        UIImage(named: "demo1.png")!,
        UIImage(named: "activities.png")!,
        UIImage(named: "news.png")!
    ]
    var logoImageCount: Int = 0
    var webviewString = [String]()
    var maxImageCount: Int = 0
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
    let descriptio = Expression<String>(DBCol.DESCRIPTION)
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

    
    //MARK: - basic functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationBar = UINavigationBar.appearance()
        self.navigationItem.hidesBackButton = false
        
        // add left and right button to activityView
        self.rightActivityButton = UIButton.init(frame: CGRect(x: self.activityView.bounds.origin.x + self.activityView.bounds.size.width/12*9.5, y: self.activityView.bounds.origin.y + self.activityView.bounds.size.height/2, width: self.activityView.bounds.size.width/12, height: self.activityView.bounds.size.width/12))
        self.rightActivityButton.setImage(UIImage.init(named: "index_right.png"), for: UIControlState.normal)
        self.leftActivityButton = UIButton.init(frame: CGRect(x: self.activityView.bounds.origin.x + self.activityView.bounds.size.width/12*1.5, y: self.activityView.bounds.origin.y + self.activityView.bounds.size.height/2, width: self.activityView.bounds.size.width/12, height: self.activityView.bounds.size.width/12))
        self.leftActivityButton.setImage(UIImage.init(named: "index_left.png"), for: UIControlState.normal)

        
        // need to initialize
        self.activityImageView = UIImageView.init(frame: self.activityView.bounds)
        
        // check app first launch
        let defaults = UserDefaults.standard
        let checkFirstLaunch = defaults.bool(forKey: "isAppFirstLaunch")
        if (checkFirstLaunch != true) {
            // is first launch
            print("app already launched")
        } else {
            print("app first launch")
        }
        
        // put image to title bar
        print(self.myNavigationItem.title!)
        self.myNavigationItem.titleView = UIView.init(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.height/12.5))
        // TODO: - need to re-render the image to the imageView size
        let logo = UIImage.init(named: "index_logo1.png")
        let logoImageView = UIImageView.init(frame: CGRect(x: self.navigationItem.titleView!.bounds.origin.x, y: self.navigationItem.titleView!.bounds.origin.y, width: self.navigationItem.titleView!.bounds.size.width * 1/5, height: self.navigationItem.titleView!.bounds.size.height))
        let logoLabel = UILabel.init(frame: CGRect(x: self.navigationItem.titleView!.bounds.origin.x + self.navigationItem.titleView!.bounds.width/5, y: self.navigationItem.titleView!.bounds.origin.y, width: self.navigationItem.titleView!.bounds.size.width * 4/5, height: self.navigationItem.titleView!.bounds.size.height))
        logoImageView.image = logo
        logoLabel.text = "台南洽公小幫手"
        self.myNavigationItem.titleView!.addSubview(logoImageView)
        self.myNavigationItem.titleView!.addSubview(logoLabel)
        self.myNavigationItem.titleView!.bringSubview(toFront: logoImageView)
        self.myNavigationItem.titleView!.bringSubview(toFront: logoLabel)
        self.myNavigationItem.titleView!.backgroundColor = UIColor.init(red: 60, green: 176, blue: 157, alpha: 1)
        
        insertData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // get maximum images to display for imageView
        self.maxImageCount = self.logoImage.count
        
        // swipe handling
        self.activityView.isUserInteractionEnabled = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(sender:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.activityView.addGestureRecognizer(swipeRight)
        self.activityView.addGestureRecognizer(swipeLeft)
        
        let pageTap = UITapGestureRecognizer(target: self, action: #selector(self.handlePageTap(sender:)))
        self.activityView.addGestureRecognizer(pageTap)
        
        // add target
        self.rightActivityButton.addTarget(self, action: #selector(ViewController.rightActivitySwitch), for: UIControlEvents.allTouchEvents)
        self.leftActivityButton.addTarget(self, action: #selector(ViewController.leftActivitySwitch), for: UIControlEvents.allTouchEvents)
        
        // image view initialization
        self.activityImageView.frame = self.activityView.bounds;
        self.activityImageView.image = self.logoImage[0]
        
        self.activityView.addSubview(self.activityImageView)
        self.activityView.bringSubview(toFront: self.activityImageView)
        
        // add button subview
        self.activityView.addSubview(self.rightActivityButton)
        self.activityView.addSubview(self.leftActivityButton)
        self.activityView.bringSubview(toFront: self.rightActivityButton)
        self.activityView.bringSubview(toFront: self.leftActivityButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - swipe handler & tap handler on pageView
    
    // switch between imageviews
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        print("logo image count: ", self.logoImageCount)
        if (sender.direction == .left) {
            // swipe left
            print("left swipe")
            self.logoImageCount -= 1
            if (self.logoImageCount < 0) {
                print("count: \(self.logoImageCount)")
                self.logoImageCount = 0
            } else {
                // assign image to imageView
                UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromRight, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
            }
        } else if (sender.direction == .right) {
            // swipe right
            print("right swipe")
            self.logoImageCount += 1
            if (self.logoImageCount > self.maxImageCount - 1) {
                print("count: \(self.logoImageCount)")
                self.logoImageCount = self.maxImageCount - 1
            } else {
                // assign image to imageView
                UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromLeft, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
            }
        }
    }
    
    // tap handler on page view
    // always open new view controller if tapped the imageview
    func handlePageTap(sender: UITapGestureRecognizer) {
        // open view controller and push into view stack
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "pageVC") as! MainPageViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    // switch to previous imageview
    func leftActivitySwitch() {
        self.logoImageCount -= 1
        if (self.logoImageCount < 0) {
            print("count: \(self.logoImageCount)")
            self.logoImageCount = 0
        } else {
            // assign image to imageView
            UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromRight, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
        }
    }
    
    // switch to next imageview
    func rightActivitySwitch() {
        self.logoImageCount += 1
        if (self.logoImageCount > self.maxImageCount - 1) {
            print("count: \(self.logoImageCount)")
            self.logoImageCount = self.maxImageCount - 1
        } else {
            // assign image to imageView
            UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromLeft, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
        }
    }
    
    
    //MARK: - collectionview delegate functions
    
    // uicollectionview delegate: 6 items in one section
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    // uicollectionviewcell: for every cell, add UIImageView and UILabel
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // configuration of cells
        if (indexPath.row == 0) {
            // get cell id and dequeue
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_one.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "messages"
            textLabel.textAlignment = NSTextAlignment.center
            
            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else if (indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_two.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "activities"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else if (indexPath.row == 2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "departmentCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_three.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "services"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else if (indexPath.row == 3) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_four.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "navigation"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else if (indexPath.row == 4) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "navigateCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_five.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "facilities"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        } else {
            // indexPath.row == 5
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "appCell", for: indexPath)
            let cellWidth = cell.bounds.width
            let cellHeight = cell.bounds.height
            
            // imageview for bg image
            let bgImageView = UIImageView(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight * 4/5))
            // re-draw image
            UIGraphicsBeginImageContext(bgImageView.bounds.size)
            UIImage(named: "change_index_icon_six.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            let bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "apps"
            textLabel.textAlignment = NSTextAlignment.center

            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            return cell;
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index: ", indexPath.row)
        if (indexPath.row == 0) {
            let storyboard = UIStoryboard(name: "Message", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else if (indexPath.row == 1) {
            self.checkFunction = 2
            let storyboard = UIStoryboard(name: "Activity", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else if (indexPath.row == 2) {
            self.checkFunction = 3
            let storyboard = UIStoryboard(name: "Service", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else if (indexPath.row == 3) {
            self.checkFunction = 4
            let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else if (indexPath.row == 4) {
            self.checkFunction = 5
            let storyboard = UIStoryboard(name: "Facility", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        } else {
            self.checkFunction = 6
            let storyboard = UIStoryboard(name: "Apps", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - insert data
    func insertData() {
        /* test databasehelper */
        let dbHelper = DatabaseHelper.init()
        dbHelper.createDB()
        
        /* test insert data into DatabaseHelper */
        // insert admin unit table
        if dbHelper.insertOrUpdateAdministrativeUnitTable(x: 1, y: 1, fieldId: "fieldId_1", unitId: "1", parentUnitId: "parentUnitId_1", name: "name_1", tel: "06-11111111", fax: "06-11111112", email: "email_1@gmail.com", website: "http://www.administrativeUnit.com", description: "first data", iconName: "iconName_1", createTime: 1, lastUpdateTime: 1, nearByPathId: "nearByPathId_1", keyword: "keyword_1") {
            print("insert admin unit table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitTable(x: 2, y: 2, fieldId: "fieldId_2", unitId: "2", parentUnitId: "parentUnitId_2", name: "name_2", tel: "06-22222222", fax: "06-22222223", email: "email_2@gmail.com", website: "http://www.administrativeUnit.com/2", description: "data2", iconName: "iconName_2", createTime: 2, lastUpdateTime: 2, nearByPathId: "nearByPathId_2", keyword: "keyword_2") {
            print("insert admin unit table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitTable(x: 3, y: 3, fieldId: "fieldId_3", unitId: "3", parentUnitId: "parentUnitId_3", name: "name_3", tel: "06-33333333", fax: "06-33333334", email: "email_3@gmail.com", website: "http://www.administrativeUnit.com/3", description: "data3", iconName: "iconName_3", createTime: 3, lastUpdateTime: 3, nearByPathId: "nearByPathId_3", keyword: "keyword_3") {
            print("insert admin unit table success.")
        }
        
        // insert admin unit cat
        if dbHelper.insertOrUpdateAdministrativeUnitCategory(categoryId: "categoryId_1", name: "administrativeUnitCategory_1", description: "data_1", iconName: "iconName_1", createTime: 1, lastUpdateTime: 1, keyword: "keyword_1") {
            print("insert admin unit category table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitCategory(categoryId: "categoryId_2", name: "administrativeUnitCategory_2", description: "data_2", iconName: "iconName_2", createTime: 2, lastUpdateTime: 2, keyword: "keyword_2") {
            print("insert admin unit category table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitCategory(categoryId: "categoryId_3", name: "administrativeUnitCategory_3", description: "data_3", iconName: "iconName_3", createTime: 3, lastUpdateTime: 3, keyword: "keyword_3") {
            print("insert admin unit category table success.")
        }
        
        // unit in cat
        if dbHelper.insertOrUpdateAdministrativeUnitInCategory(unitId: "unitId_1", categoryId: "categoryId_1", lastUpdateTime: 1) {
            print("insert admin unit in category table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitInCategory(unitId: "unitId_2", categoryId: "categoryId_2", lastUpdateTime: 2) {
            print("insert admin unit in category table success.")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitInCategory(unitId: "unitId_3", categoryId: "categoryId_3", lastUpdateTime: 3) {
            print("insert admin unit in category table success.")
        }
        
        // keyword table
        if dbHelper.insertOrUpdateKeywordTable(keywordId: "keywordId_1", keyword: "keyword_1", rank: 1, description: "keyword_table_1", createTime: 1, lastUpdateTime: 1) {
            print("insert keyword table success")
        }
        if dbHelper.insertOrUpdateKeywordTable(keywordId: "keywordId_2", keyword: "keyword_2", rank: 2, description: "keyword_table_2", createTime: 2, lastUpdateTime: 2) {
            print("insert keyword table success")
        }
        if dbHelper.insertOrUpdateKeywordTable(keywordId: "keywordId_3", keyword: "keyword_3", rank: 3, description: "keyword_table_3", createTime: 3, lastUpdateTime: 3) {
            print("insert keyword table success")
        }
        
        // in keyword
        if dbHelper.insertOrUpdateInKeywordTable(id: "1", keywordId: "keywordId_1", lastUpdateTime: 1) {
            print("insert in keyword table success")
        }
        if dbHelper.insertOrUpdateInKeywordTable(id: "2", keywordId: "keywordId_2", lastUpdateTime: 2) {
            print("insert in keyword table success")
        }
        if dbHelper.insertOrUpdateInKeywordTable(id: "3", keywordId: "keywordId_3", lastUpdateTime: 3) {
            print("insert in keyword table success")
        }
        
        // edm
        if dbHelper.insertOrUpdateEdmTable(edmId: "id1", edmName: "string", edmURL: "http://www.google.com", edmImage: "image.png", edmEndDay: "01/21/1111", lastUpdateTime: 1) {
            print("insert edm table success.")
        }
        if dbHelper.insertOrUpdateEdmTable(edmId: "id2", edmName: "string2", edmURL: "http://www.google.com/2", edmImage: "image2.png", edmEndDay: "01/21/1111", lastUpdateTime: 2) {
            print("insert edm table success.")
        }
        if dbHelper.insertOrUpdateEdmTable(edmId: "id3", edmName: "string3", edmURL: "http://www.google.com/3", edmImage: "image3.png", edmEndDay: "01/21/1111", lastUpdateTime: 3) {
            print("insert edm table success.")
        }
        
        // mobile app
        if dbHelper.insertOrUpdateMobileAppTable(appId: "appId_1", appName: "app 1", appURL: "itunes.apple.com", appImage: "image.png", lastUpdateTime: 1) {
            print("insert mobile app table success.")
        }
        if dbHelper.insertOrUpdateMobileAppTable(appId: "appId_2", appName: "app 2", appURL: "itunes.apple.com", appImage: "image2.png", lastUpdateTime: 2) {
            print("insert mobile app table success.")
        }
        if dbHelper.insertOrUpdateMobileAppTable(appId: "appId_3", appName: "app 3", appURL: "itunes.apple.com", appImage: "image3.png", lastUpdateTime: 3) {
            print("insert mobile app table success.")
        }
    }
    
    func readDataFromTainanSQLite() {
        // let dbURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("tainan")
        let path2 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbName = "tainan.sqlite"
        let tempDB = path2 + dbName
        do {
            // db connection to tainan.sqlite
            let db = try Connection(tempDB)
            
            // define tables
            let adminUnitTable = Table("administrativeunit")
            let adminUnitCatTable = Table("administrativeunitcategory")
            let adminUnitInCatTable = Table("administrativeunitincategory")
            let edmTable = Table("edm")
            let hotTable = Table("hot")
            let inKeyTable = Table("inKeyword")
            let instructionTable = Table("instruction")
            let keywordTable = Table("keyword")
            let mappingKeyTable = Table("mappingKeyword")
            let mobileTable = Table("mobileApp")
            
            // query and store data
            let adminUnits = NSMutableArray()
            for units in try db.prepare(adminUnitTable) {
                let temp = AdministrativeUnit(x: units[self.x], y: units[self.y], fieldId: units[self.fieldId], unitId: units[self.unitId], parentUnitId: units[self.parentUnitId], name: units[self.name], tel: units[self.tel], fax: units[self.fax], email: units[self.email], website: units[self.website], description: units[self.descriptio], iconName: units[self.iconName], createTime: units[self.createTime], lastUpdateTime: units[self.lastUpdateTime], nearByPathId: units[self.nearByPathId], keyword: units[self.keyword])
                adminUnits.add(temp)
            }
            
            let adminUnitsCat = NSMutableArray()
            for cats in try db.prepare(adminUnitCatTable) {
                let temp = AdministrativeUnitCategory(categoryId: cats[self.categoryId], name: cats[self.name], description: cats[self.descriptio], iconName: cats[self.iconName], createTime: cats[self.createTime], lastUpdateTime: cats[self.lastUpdateTime], keyword: cats[self.keyword])
                adminUnitsCat.add(temp)
            }
            
            let adminUnitsInCat = NSMutableArray()
            for ins in try db.prepare(adminUnitInCatTable) {
                let temp = AdministrativeUnitInCategory(unitId: ins[self.unitId], categoryId: ins[self.categoryId], lastUpdateTime: ins[self.lastUpdateTime])
                adminUnitsInCat.add(temp)
            }
            
            let edms = NSMutableArray()
            for edmm in try db.prepare(edmTable) {
                let temp = Edm(edmId: edmm[self.edmId], edmName: edmm[self.edmName], edmURL: edmm[self.edmURL], edmImage: edmm[self.edmImage], edmEndDay: edmm[self.edmEndDay], lastUpdateTime: edmm[self.lastUpdateTime])
                edms.add(temp)
            }
            
            let hots = NSMutableArray()
            for hott in try db.prepare(hotTable) {
                let temp = HotItem(id: hott[self.id], hotDate: hott[self.hotDate], hotTitle: hott[self.hotTitle], hotDescription: hott[self.hotDescription], hotLink: hott[self.hotLink], isDelete: hott[self.isDelete])
                hots.add(temp)
            }
            
            let inKeys = NSMutableArray()
            for keys in try db.prepare(inKeyTable) {
                let temp = InKeywords(id: String(keys[self.stringId]), keywordId: keys[self.keywordId], lastUpdateTime: keys[self.lastUpdateTime])
                inKeys.add(temp)
            }
            
            let instructs = NSMutableArray()
            for instrs in try db.prepare(instructionTable) {
                let temp = InstructionItem(id: instrs[self.id], name: instrs[self.name], read: instrs[self.read])
                instructs.add(temp)
            }
            
            let keys = NSMutableArray()
            for k in try db.prepare(keywordTable) {
                let temp = Keyword(keywordId: k[self.keywordId], keyword: k[self.keyword], rank: k[self.rank], description: k[self.descriptio], createTime: k[self.createTime], lastUpdateTime: k[self.lastUpdateTime])
                keys.add(temp)
            }
            
            let mappings = NSMutableArray()
            for maps in try db.prepare(mappingKeyTable) {
                let temp = MappingKeyword(unitId: maps[self.unitId], keyword: maps[self.keyword])
                mappings.add(temp)
            }
            
            let mobiles = NSMutableArray()
            for mobs in try db.prepare(mobileTable) {
                let temp = MobileApps(appId: mobs[self.appId], appName: mobs[self.appName], appURL: mobs[self.appURL], appImage: mobs[self.appImage], lastUpdateTime: mobs[self.lastUpdateTime])
                mobiles.add(temp)
            }
            
            
            
//            let administrativeUnitCategories = NSMutableArray()
//            do {
//                let administrativeUnitCategoryTable = Table(DBCol.TABLE_ADMINISTRATIVE_UNIT_CATEGORY)
//                let db = try Connection(Constants.DB_FULLPATH)
//                for categories in try db.prepare(administrativeUnitCategoryTable) {
//                    let adminUnitCategory = AdministrativeUnitCategory(categoryId: categories[self.categoryId], name: categories[self.name], description: categories[self.description], iconName: categories[self.iconName], createTime: categories[self.createTime], lastUpdateTime: categories[self.lastUpdateTime], keyword: categories[self.keyword])
//                    administrativeUnitCategories.add(adminUnitCategory)
//                }
//                print("query administrative unit category table succeed.")
//            } catch _ {
//                print("query administrative unit category table fail.")
//            }
            
        } catch _ {
            print("there is error.")
        }
    }
    
}

