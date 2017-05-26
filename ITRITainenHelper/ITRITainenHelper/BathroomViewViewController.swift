//
//  BathroomViewViewController.swift
//  testyu
//
//  Created by uscc on 2017/4/19.
//  Copyright © 2017年 uscc. All rights reserved.
//

import UIKit

class BathroomViewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var list = [String]()

    @IBOutlet weak var mytable: UITableView!
    var info = ["1樓東側廁所","1樓西側廁所","2樓東側廁所","2樓西側廁所","3樓東側廁所","3樓西側廁所","4樓東側廁所","4樓西側廁所","5樓東側廁所","5樓西側廁所","6樓東側廁所","6樓西側廁所","7樓東側廁所","7樓西側廁所","8樓東側廁所","8樓西側廁所","9樓東側廁所","9樓西側廁所","10樓東側廁所","10樓西側廁所","11樓東側廁所","11樓西側廁所","12樓東側廁所","12樓西側廁所","13樓廁所","14樓廁所","15樓廁所","16樓廁所"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*mytable.register(
            UITableViewCell.self, forCellReuseIdentifier: "Cell")
 */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    // 必須實作的方法：每一組有幾個 cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! Bathroomcell
        //cell.img.text = "\(indexPath.row)"
        cell.textlabel.text = info[indexPath.row]
        //let imgname = indexPath.row % 2 == 0 ?"close.png":"1.png"
        cell.img.image = UIImage(named: indexPath.row % 2 == 0 ?"index_logo1.png":"govenment_128.png")
        
        /*if indexPath.row % 2 == 0{
            cell.img.image = UIImage(named: "close.png")
        }
        else{
            cell.img.image = UIImage(named: "1.png")
        }*/

        //cell.btn1.numberOfLines = 0;
        //cell.btn2.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        
        return cell
    }

    
    /*
    // 必須實作的方法：每個 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as UITableViewCell
        
        
        
     
        // 設置 Accessory 按鈕樣式
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.accessoryType = .checkmark
            } else if indexPath.row == 1 {
                cell.accessoryType = .detailButton
            } else if indexPath.row == 2 {
                cell.accessoryType = .detailDisclosureButton
            } else if indexPath.row == 3 {
                cell.accessoryType = .disclosureIndicator
            }
        }
        
        // 顯示的內容
        if let myLabel = cell.textLabel {
            myLabel.text = "\(info[indexPath.row])"
        }
     
        return cell
    }
    */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
