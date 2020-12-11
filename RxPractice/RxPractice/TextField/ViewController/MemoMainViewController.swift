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
    
    private var notificationToken: NotificationToken?
    private var realm: Realm!
    private var model : Results<MemoDetailObject>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        realm = try! Realm()
        model = realm.objects(MemoDetailObject.self).sorted(byKeyPath: "lastEditDate", ascending: false)
        notificationToken = model.observe({ _ in
            self.mTableView.reloadData()
        })
        
//        notificationToken = realm.observe { [unowned self] _, _ in
//            memoMainViewModel.rx.isUpdate
//                .subscribe { [weak self] isUpdate in
//                    self?.needUpdate(isUpdate)
//                }
//        }
    }
//
//    func needUpdate(_ isUpdate : Bool){
//        if isUpdate == true {
//            mTableView.reloadData()
//        }
//    }
    
    @IBAction func mAddBtnPressed(_ sender: UIButton) {
        memoMainViewModel.pushAddViewCon()
    }
    
    
}

extension MemoMainViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
            cell.textLabel?.text = model[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        memoMainViewModel.pushDetailViewCon(model[indexPath.row])
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
