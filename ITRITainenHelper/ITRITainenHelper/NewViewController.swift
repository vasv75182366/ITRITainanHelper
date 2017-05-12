//
//  NewViewController.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/11.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class NewViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webActivity: UIWebView!
    
    var overlay: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    var webLink: String! = "https://www.google.com.tw"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        view.addSubview(overlay)
        activityIndicator.startAnimating()
        loadWeb()
    }
    
    func loadWeb(){
        let range =  webLink.range(of: "=")
        let host = webLink.substring(to: (range?.lowerBound)!)
        var data = webLink.substring(from: (range?.lowerBound)!)
        data = data.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let url = URL(string: host + data)
        let request = URLRequest(url: url!)
        webActivity.loadRequest(request)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        activityIndicator.stopAnimating()
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
