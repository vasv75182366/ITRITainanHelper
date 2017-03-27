//
//  ViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/16/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    // activity view: has to add image as bg
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var functionCollection: UICollectionView!
    weak var navigationBar: UINavigationBar!
    var cellBgImage: UIImage!
    var titleCombineView: UIView!
    var checkFunction: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationBar = UINavigationBar.appearance()
        // self.navigationBar.backItem = nil
        self.navigationItem.hidesBackButton = false
        // self.navigationBar.titleTextAttributes =
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
            var bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "messages"
            
            // add subview and bring to front
            cell.contentView.addSubview(bgImageView)
            cell.contentView.addSubview(textLabel)
            cell.contentView.bringSubview(toFront: bgImageView)
            cell.contentView.bringSubview(toFront: textLabel)
            
            let tap =  UITapGestureRecognizer.init(target: self, action: #selector(self.handleTap(_:)))
            collectionView.addGestureRecognizer(tap)
            collectionView.isUserInteractionEnabled = true
            
            self.checkFunction = 1
            
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
            var bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "activities"
            
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
            var bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "services"
            
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
            var bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "navigation"
            
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
            var bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "facilities"
            
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
            UIImage(named: "change_index_icon_fix.png")!.draw(in: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cellWidth, height: cellHeight*4/5), blendMode: CGBlendMode.color, alpha: 1.0)
            var bgImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            // image for imageview
            bgImageView.image = bgImage
            
            // UILabel
            let textLabel = UILabel(frame: CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y+(cellHeight * 4/5), width: cellWidth, height: (cellHeight * 1/5)))
            textLabel.text = "apps"
            
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
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        // open corresponding storyboard
        switch self.checkFunction {
        case 1:
            // open "Message" storyboard with initial VC
            let storyboard = UIStoryboard(name: "Message", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
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
        case 5:
            let storyboard = UIStoryboard(name: "Facility", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
            break
        case 6:
            let storyboard = UIStoryboard(name: "Apps", bundle: nil)
            let controller = storyboard.instantiateInitialViewController()!
            self.present(controller, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
}

