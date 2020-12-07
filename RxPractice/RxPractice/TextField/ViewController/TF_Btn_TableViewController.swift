//
//  TF_Btn_TableViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/07.
//

import UIKit
import RealmSwift

class SearchHistoryObject: Object {
    @objc dynamic var searchText = ""
}

class TF_Btn_TableViewController: C_ViewController {
    
    @IBOutlet weak var mSearchView: TF_ButtonView!
    @IBOutlet weak var mTableView: UITableView!
    
    var notificationToken: NotificationToken?
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        
        notificationToken = realm.observe { [unowned self] _, _ in
            self.mTableView.reloadData()
        }
        
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        bind()
    }
    
    func bind(){
        mSearchView.rx.tapConfirmBtn
            .bind { [weak self] title in
                self?.addRealm(title)
            }
    }
    
    @objc func addRealm(_ text : String?) {
        try! realm.write {
            realm.add(SearchHistoryObject(value: ["searchText" : text]))
        }
        mTableView.reloadData()
    }
    
    
    @IBAction func mResetHistoryBtnPressed(_ sender: UIButton) {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
}
extension TF_Btn_TableViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(SearchHistoryObject.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        let item = realm.objects(SearchHistoryObject.self)[indexPath.row]
        cell.textLabel?.text = item.searchText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
