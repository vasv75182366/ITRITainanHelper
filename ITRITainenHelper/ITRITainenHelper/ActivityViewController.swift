//
//  ActivityViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 3/26/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit
import FeedKit
import SQLite


class ActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items = [ActivityRSSFormat]()
    var hidesitems = [ActivityRSSFormat]()
    let fullScreenSize = UIScreen.main.bounds.size
    var overlay: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    @IBOutlet weak var tvActivity: UITableView!
    @IBOutlet weak var navigationbar: UINavigationBar!
    @IBOutlet weak var mswitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvActivity.layoutMargins = UIEdgeInsets.zero
        // set overlay
        overlay.frame = CGRect(x: 0,y: 0, width: view.frame.size.width * 0.8, height: 90)
        overlay.center = self.view.center
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.5
        overlay.layer.cornerRadius = 10
        overlay.clipsToBounds = true
        // set loading indicator
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height:60)
        activityIndicator.center = CGPoint(x: overlay.frame.size.width / 2, y: overlay.frame.size.height / 2);
        activityIndicator.hidesWhenStopped = true
        
        overlay.addSubview(activityIndicator)
        self.view.addSubview(overlay)
        activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadActivity()
    }
    
    func loadActivity(){
        // call API and transfer response to rss format
        let url = URL(string: "http://www.tainan.gov.tw/tainan/rss.asp?nsub=__A4A0")!
        
        DispatchQueue.global(qos: .userInitiated).async {
            FeedParser(URL: url)?.parse({ (result) in
                DispatchQueue.main.async {
                    let list = result.rssFeed?.items!
                    for item in list! {
                        self.items.append(ActivityRSSFormat(title: item.title, pubDate: item.pubDate, link: item.link))
                    }
                    print(self.items.count)
                    self.tvActivity.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.overlay.removeFromSuperview()
                }
            })
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func btnClick(button:UIButton){
        
        let alertController = UIAlertController(title: "btnclick", message: "\(button.tag)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        
        let st = "\(String(describing: items[indexPath.row].pubDate))"
        var range = st.range(of: "(")
        var data = st.substring(from: (range?.upperBound)!)
        range = data.range(of: " +")
        data = data.substring(to: (range?.lowerBound)!)
        cell.index.text = "\(indexPath.row)"
        cell.title.text = items[indexPath.row].title
        cell.title.numberOfLines = 0;
        cell.title.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.date.text = "發布日期" + "\(String(describing: data))"
        cell.date.numberOfLines = 0;
        cell.date.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.btn.tag = indexPath.row
        cell.btn.setBackgroundImage(#imageLiteral(resourceName: "recycle_bin"), for: UIControlState())
        cell.btn.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
        vc.webLink = items[indexPath.row].link
        show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMessage() {
        let alertController = UIAlertController(title: "Loading...", message: "\n\(items.count)\n\n", preferredStyle: .alert)
        
        let loading = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loading.center = CGPoint(x:30,y:30)
        loading.color = UIColor.black
        loading.startAnimating()
        
        /*let indicatorLength: CGFloat = 30.0   //正方形
         let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
         indicatorView.frame = CGRect(x: (rootRect?.width)!/2-indicatorLength/2, y: (rootRect?.height)!/2-indicatorLength/2, width: indicatorLength, height: indicatorLength)
         */
        alertController.view.addSubview(loading)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backEvent(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        self.present(controller, animated: true, completion: nil)
    }
}
