//
//  ViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    
    var mSection : [String] = ["TextField"]
    var mArray : [String] = ["TF_Btn_LB", "TF_Btn_Table", ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return mSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mSection[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = mArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(TF_Btn_LBViewController(), animated: true)
    }
    
}

