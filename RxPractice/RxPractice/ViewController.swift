//
//  ViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var mSectionList = [["section" : "TextField" , "list" : ["TF_Btn_LB", "TF_Btn_Table"]],
                        ["section" : "ToyPractice" , "list" : ["Memo"]]]
    
//    var mSection : [String] = ["TextField"]
//    var mArray : [String] = ["TF_Btn_LB", "TF_Btn_Table"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return mSectionList.count
//        return mSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = mSectionList[section]["section"] as? String else{
            return "No Title"
        }
        
        return title
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = mSectionList[section]["list"] as? Array<Any> else{
            return 0
        }

        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        guard let list = mSectionList[indexPath.section]["list"] as? Array<String> else{
            return cell
        }
        
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var viewCon : UIViewController
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                viewCon = TF_Btn_LBViewController()
            }else{
                viewCon = TF_Btn_TableViewController()
            }
        }else{
            viewCon = MemoMainViewController()
        }
        
        
        self.navigationController?.pushViewController(viewCon, animated: true)
    }
    
}

