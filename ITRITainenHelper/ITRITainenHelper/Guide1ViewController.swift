//
//  Guide1ViewController.swift
//  ITRITainenHelper
//
//  Created by uscc on 2017/5/26.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit
import Foundation

class Guide1ViewController: UIViewController {

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lbGuide: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        lbGuide.text = "上\n下\n滑\n動\n以\n瀏\n覽\n內\n容";
        lbGuide.numberOfLines = lbGuide.text!.characters.count
        // Do any additional setup after loading the view.
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
