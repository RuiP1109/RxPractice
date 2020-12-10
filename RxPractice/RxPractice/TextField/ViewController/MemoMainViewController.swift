//
//  MemoMainViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/09.
//

import UIKit
import RxSwift
import RealmSwift

class MemoMainViewController: C_ViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    private lazy var memoMainViewModel = MemoMainViewModel(parent: self)
    var disposeBag = DisposeBag()
    
    var notificationToken: NotificationToken?
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        realm = try! Realm()
        notificationToken = realm.observe { [unowned self] _, _ in
            memoMainViewModel.rx.isUpdate
                .subscribe { [weak self] isUpdate in
                    self?.needUpdate(isUpdate)
                }
        }
        
//        memoMainViewModel.rx.list
//            .subscribe { (result) in
//                print("🧡🧡result : \(result)")
//            }
//            .disposed(by: disposeBag)
        
    }
    
    func needUpdate(_ isUpdate : Bool){
        print("🧡🧡needUpdate : \(isUpdate)")
        if isUpdate == true {
            mTableView.reloadData()
        }
    }
    
    @IBAction func mAddBtnPressed(_ sender: UIButton) {
        memoMainViewModel.pushAddViewCon()
//        navigationController?.pushViewController(MemoAddViewController(delegate: self), animated: true)
    }
    
    
}

extension MemoMainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(MemoDetailObject.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        let item = realm.objects(MemoDetailObject.self)[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        memoMainViewModel.pushAddViewCon()
        
//        navigationController?.pushViewController(MemoAddViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            memoMainViewModel.deleteModelInfo(indexPath.row)
        }
    }
    
}
