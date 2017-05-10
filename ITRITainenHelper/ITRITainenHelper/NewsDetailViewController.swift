//
//  NewsDetailViewController.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/10.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webNews: UIWebView!
    
    var webLink: String! = "https://www.google.com.tw"
    var overlay = UIView()
    var loading: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set overlay
        overlay.frame = CGRect(x: 0, y: 0, width: view.frame.size.width * 0.8, height: 90)
        overlay.center = self.view.center
        overlay.backgroundColor = UIColor.black
        overlay.alpha = 0.5
        overlay.layer.cornerRadius = 10
        overlay.clipsToBounds = true
        // set loading indicator
        loading.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loading.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.white
        loading.center = CGPoint(x: overlay.frame.size.width / 2,
                                 y: overlay.frame.size.height / 2);
        loading.hidesWhenStopped = true
        
        overlay.addSubview(loading)
        view.addSubview(overlay)
        loading.startAnimating()
        loadWeb()
    }
    // web load
    func loadWeb() {
        let range = webLink.range(of: "=")
        let host = webLink.substring(to: (range?.lowerBound)!)
        var data = webLink.substring(from: (range?.lowerBound)!)
        data = data.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let url = URL(string: host + data)
        let request = URLRequest(url: url!)
        webNews.loadRequest(request)
    }
    // web finish to load
    func webViewDidFinishLoad(_ webView: UIWebView) {
        loading.stopAnimating()
        self.overlay.removeFromSuperview()
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
