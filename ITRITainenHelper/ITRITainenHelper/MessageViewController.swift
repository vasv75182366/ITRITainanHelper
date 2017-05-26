//
//  MessageViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/26/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import FeedKit

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tvNews: UITableView!
    
    var items = [RSSFormat]()   // store news
    var overlay = UIView()      // black frame
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()  // loading indicator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let checkFirstLaunch = defaults.bool(forKey: "isAppFirstLaunch")
        if (checkFirstLaunch != true) {
            // is first launch
            setGuideLayout()
        } else {
            setGeneralLayout()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadNews()
    }

    // set Guide layout
    func setGuideLayout() {
        // set button
        let btnCheck: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 210, height: 73))
        btnCheck.setTitle("確定", for: .normal)
        btnCheck.setTitleColor(UIColor.white, for: .normal)
        btnCheck.isEnabled = true
        btnCheck.setImage(UIImage(named: "instruction_button.png"), for: .normal)
        btnCheck.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.3)
        // set label
        let lbGuide: UILabel = UILabel()
        lbGuide.bounds.origin = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.5)
        lbGuide.text = "上下滑動以瀏覽內容"
        lbGuide.textColor = UIColor.white
        lbGuide.font = UIFont.systemFont(ofSize: 18)
        // set image
        let imgHand: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 207, height: 255))
        imgHand.image = UIImage(named: "up_down_hand.png")
        imgHand.center = CGPoint(x: view.frame.size.width * 0.7, y: view.frame.size.height * 0.7)
        // add component to view
        view.addSubview(btnCheck)
        view.addSubview(lbGuide)
        view.addSubview(imgHand)
        
    }
    
    // set gerneral layout
    func setGeneralLayout() {
        self.tvNews.layoutMargins = UIEdgeInsets.zero
        // set overlay
        overlay.frame = CGRect(x: 0, y: 0, width: view.frame.size.width * 0.8, height: 90)
        overlay.center = self.view.center
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.5
        overlay.layer.cornerRadius = 10
        overlay.clipsToBounds = true
        // set loading indicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        activityIndicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.white
        activityIndicator.center = CGPoint(x: overlay.frame.size.width / 2,
                                           y: overlay.frame.size.height / 2);
        activityIndicator.hidesWhenStopped = true
        
        overlay.addSubview(activityIndicator)
        view.addSubview(overlay)
        activityIndicator.startAnimating()
    }
    
    // News loading
    func loadNews() {
        // call API and transfer response to rss format
        let url = URL(string: "http://www.tainan.gov.tw/tainan/rss.asp?nsub=__A100")!
        
        DispatchQueue.global(qos: .userInitiated).async {
            // Run parsing in a background thread
            FeedParser(URL: url)?.parse({ (result) in
                DispatchQueue.main.async {
                    // Perform updates in the main thread when finished
                    let list = result.rssFeed?.items!
                    for item in list! {
                        self.items.append(RSSFormat(title: item.title, pubDate: item.pubDate, link: item.link))
                    }
                    self.tvNews.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.overlay.removeFromSuperview()
                }
            })
        }
    }
    // return number of section in tableview
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // return number of tableview cell in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    // return tableview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsCell
        cell.lbIndex.text = "\(indexPath.row)"
        cell.lbTitle.text = items[indexPath.row].title
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    // custom click event of tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        vc.webLink = items[indexPath.row].link
        show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }

    @IBAction func backEvent(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        self.present(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
