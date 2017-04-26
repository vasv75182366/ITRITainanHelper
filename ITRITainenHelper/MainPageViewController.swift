//
//  MainPageViewController.swift
//  ITRITainenHelper
//
//  Created by Oslo on 4/13/17.
//  Copyright © 2017 uscc. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    var webviewString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webviewString = "https://google.com"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // load request everytime the VC is appeared
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let url = URL(string: self.webviewString)
        let requestObj = URLRequest(url: url!)
        
        self.pageWebView.loadRequest(requestObj)
    }
    
    
    @IBOutlet weak var returnButtonAction: UIBarButtonItem!
    @IBOutlet weak var pageWebView: UIWebView!
    
    // back button action: dismiss view controller
    @IBAction func returnHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
