//
//  ViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/16/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import SQLite


class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - variables
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
    // activity view: has to add image as bg
    @IBOutlet weak var activityView: UIView!
    var activityImageView: UIImageView!
    @IBOutlet weak var functionCollection: UICollectionView!
    weak var navigationBar: UINavigationBar!
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

    
    //MARK: - basic functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationBar = UINavigationBar.appearance()
        self.navigationItem.hidesBackButton = false
        
        /* test databasehelper */
        let dbHelper = DatabaseHelper.init()
        dbHelper.createDB()
        
        /* test insert data into DatabaseHelper */
        if dbHelper.insertOrUpdateAdministrativeUnitTable(x: 1, y: 1, fieldId: "fieldId_1", unitId: "1", parentUnitId: "parentUnitId_1", name: "name_1", tel: "06-11111111", fax: "06-11111112", email: "email_1@gmail.com", website: "http://www.administrativeUnit.com", description: "first data", iconName: "iconName_1", createTime: 1, lastUpdateTime: 1, nearByPathId: "nearByPathId_1", keyword: "keyword_1") {
            print("success 1")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitTable(x: 2, y: 2, fieldId: "fieldId_2", unitId: "2", parentUnitId: "parentUnitId_2", name: "name_2", tel: "06-22222222", fax: "06-22222223", email: "email_2@gmail.com", website: "http://www.administrativeUnit.com/2", description: "data2", iconName: "iconName_2", createTime: 2, lastUpdateTime: 2, nearByPathId: "nearByPathId_2", keyword: "keyword_2") {
            print("success 2")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitCategory(categoryId: "categoryId_1", name: "administrativeUnitCategory_1", description: "data_1", iconName: "iconName_1", createTime: 1, lastUpdateTime: 1, keyword: "keyword_1") {
            print("success 3")
        }
        
        if dbHelper.insertOrUpdateAdministrativeUnitCategory(categoryId: "categoryId_2", name: "administrativeUnitCategory_2", description: "data_2", iconName: "iconName_2", createTime: 2, lastUpdateTime: 2, keyword: "keyword_2") {
            print("success 4")
        }

        if dbHelper.insertOrUpdateAdministrativeUnitInCategory(unitId: "unitId_1", categoryId: "categoryId_1", lastUpdateTime: 1) {
            print("success 5")
        }
        if dbHelper.insertOrUpdateAdministrativeUnitInCategory(unitId: "unitId_2", categoryId: "categoryId_2", lastUpdateTime: 2) {
            print("success 6")
        }
        
        if dbHelper.insertOrUpdateKeywordTable(keywordId: "keywordId_1", keyword: "keyword_1", rank: 1, description: "keyword_table_1", createTime: 1, lastUpdateTime: 1) {
            print("success 7")
        }
        if dbHelper.insertOrUpdateKeywordTable(keywordId: "keywordId_2", keyword: "keyword_2", rank: 2, description: "keyword_table_2", createTime: 2, lastUpdateTime: 2) {
            print("success 8")
        }
        
        if dbHelper.insertOrUpdateInKeywordTable(id: "1", keywordId: "keywordId_1", lastUpdateTime: 1) {
            print("success 9")
        }
        if dbHelper.insertOrUpdateInKeywordTable(id: "2", keywordId: "keywordId_2", lastUpdateTime: 2) {
            print("success 10")
        }

        if dbHelper.insertOrUpdateEdmTable(edmId: "id1", edmName: "string", edmURL: "http://www.google.com", edmImage: "image.png", edmEndDay: "01/21/1111", lastUpdateTime: 3) {
            print("success 11")
        }

        if dbHelper.insertOrUpdateMobileAppTable(appId: "appId_1", appName: "app 1", appURL: "itunes.apple.com", appImage: "image.png", lastUpdateTime: 1) {
            print("success 12")
        }
        
        /* test query */
        let adminUnitArray = dbHelper.queryAdministrativeUnitTable()
        let adminUniCategoryArray = dbHelper.queryAdministrativeUnitCategoryTable()
        let unitInCategoryArray = dbHelper.queryAdministrativeUnitInCategoryTable()
        let keywordArray = dbHelper.queryKeywordTable()
        let inKeywordArray = dbHelper.queryInKeywordTable()
        let edmArray = dbHelper.queryEdmTable()
        let mobileAppArray = dbHelper.queryMobileAppTable()
        print(adminUnitArray)
        print(adminUniCategoryArray)
        print(unitInCategoryArray)
        print(keywordArray)
        print(inKeywordArray)
        print(edmArray)
        print(mobileAppArray)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // swipe handling
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector(("handleSwipes:")))
        leftSwipe.direction = UISwipeGestureRecognizerDirection.left
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector(("handleSwipes:")))
        rightSwipe.direction = UISwipeGestureRecognizerDirection.right
        self.activityView.addGestureRecognizer(leftSwipe)
        self.activityView.addGestureRecognizer(rightSwipe)
        let pageTap = UITapGestureRecognizer(target: self, action: Selector(("handlePageTap:")))
        self.activityView.addGestureRecognizer(pageTap)
        
        // image view initialization
//        self.activityImageView.frame = CGRect(x: self.activityView.bounds.origin.x, y: self.activityView.bounds.origin.y, width: self.activityView.bounds.width, height: self.activityView.bounds.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - swipe handler & tap handler on pageView
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            // swipe left
            self.logoImageCount -= 1
            if (self.logoImageCount < 0) {
                self.logoImageCount = 0
            }
            // assign image to imageView
            UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromLeft, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
        } else {
            // swipe right
            self.logoImageCount += 1
            if (self.logoImageCount > 2) {
                self.logoImageCount = 2
            }
            // assign image to imageView
            UIView.transition(with: self.activityView, duration: 1, options: .transitionFlipFromRight, animations: { self.activityImageView.image = self.logoImage[self.logoImageCount] }, completion: nil)
        }
    }
    
    
    // tap handler on page view
    func handlePageTap(sender: UITapGestureRecognizer) {
        switch self.logoImageCount {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "pageVC") as! MainPageViewController
            controller.webviewString = self.webviewString[self.logoImageCount]
            self.present(controller, animated: true, completion: nil)
            break
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "pageVC") as! MainPageViewController
            controller.webviewString = self.webviewString[self.logoImageCount]
            self.present(controller, animated: true, completion: nil)
            break
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "pageVC") as! MainPageViewController
            controller.webviewString = self.webviewString[self.logoImageCount]
            self.present(controller, animated: true, completion: nil)
            break
        default: break
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
            self.checkFunction = 1

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
            textLabel.text = "市府訊息"
            textLabel.textAlignment = NSTextAlignment.center
            
            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            let tap =  UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
            collectionView.addGestureRecognizer(tap)
            collectionView.isUserInteractionEnabled = true
            
            print("test")
            
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
            
            let tap =  UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
            collectionView.addGestureRecognizer(tap)
            collectionView.isUserInteractionEnabled = true
            
            self.checkFunction = 2
            
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
            
            let tap =  UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
            collectionView.addGestureRecognizer(tap)
            collectionView.isUserInteractionEnabled = true
            
            self.checkFunction = 3
            
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
            
            let tap =  UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
            collectionView.addGestureRecognizer(tap)
            collectionView.isUserInteractionEnabled = true
            
            self.checkFunction = 4
            
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
            
            let tap =  UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
            collectionView.addGestureRecognizer(tap)
            collectionView.isUserInteractionEnabled = true
            
            self.checkFunction = 5
            
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
            
            let tap =  UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
            collectionView.addGestureRecognizer(tap)
            collectionView.isUserInteractionEnabled = true
            
            self.checkFunction = 6
            
            return cell;
        }
    }
    
    
    //MARK: - tap processing
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        print("testß", self.checkFunction)
        
        // open corresponding storyboard
        switch self.checkFunction {
        case 5:
            // open "Message" storyboard with initial VC
            let storyboard = UIStoryboard(name: "Message", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            print("Message test.")
            self.present(controller, animated: true, completion: nil)
            break
        case 2:
            let storyboard = UIStoryboard(name: "Activity", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
            break
        case 3:
            let storyboard = UIStoryboard(name: "Service", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
            break
        case 4:
            let storyboard = UIStoryboard(name: "Navigation", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
            break
        case 6:
            let storyboard = UIStoryboard(name: "Facility", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
            break
        case 0:
            let storyboard = UIStoryboard(name: "Apps", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
}

