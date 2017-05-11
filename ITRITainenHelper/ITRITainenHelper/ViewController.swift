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
        
        /* test query */
//        let adminUnitArray = dbHelper.queryAdministrativeUnitTable()
//        let adminUniCategoryArray = dbHelper.queryAdministrativeUnitCategoryTable()
//        let unitInCategoryArray = dbHelper.queryAdministrativeUnitInCategoryTable()
//        let keywordArray = dbHelper.queryKeywordTable()
//        let inKeywordArray = dbHelper.queryInKeywordTable()
//        let edmArray = dbHelper.queryEdmTable()
//        let mobileAppArray = dbHelper.queryMobileAppTable()
//        print(adminUnitArray)
//        print(adminUniCategoryArray)
//        print(unitInCategoryArray)
//        print(keywordArray)
//        print(inKeywordArray)
//        print(edmArray)
//        print(mobileAppArray)
    }
}

