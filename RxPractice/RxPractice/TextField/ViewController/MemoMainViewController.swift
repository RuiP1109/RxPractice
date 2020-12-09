//
//  MemoMainViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/09.
//

import UIKit

class MemoMainViewController: C_ViewController {

    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarTitle(text: "메모", offsetY: 30)
        
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

}

extension MemoMainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.backgroundColor = .yellow
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(MemoAddViewController(), animated: true)
    }
}
