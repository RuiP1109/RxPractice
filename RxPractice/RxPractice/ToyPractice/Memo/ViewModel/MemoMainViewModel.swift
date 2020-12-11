//
//  MemoViewModel.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/10.
//

import Foundation
import RxSwift
import RealmSwift

class MemoMainViewModel{
    
    private weak var parent: UIViewController?
    
    fileprivate var deletePublishSubject = PublishSubject<Int>()
    fileprivate var isUpdatePublishSubject = PublishSubject<Bool>()
    
    fileprivate var realm: Realm!
    fileprivate var notificationToken: NotificationToken?
    
    init(parent : UIViewController?) {
        self.parent = parent
        realm = try! Realm()
        bind()
    }
    
    func bind(){

        deletePublishSubject
            .subscribe { [weak self] index in
                self?.deleteModelInfo(index)
        }
        
        notificationToken = realm.observe { [unowned self] _, _ in
            isUpdatePublishSubject.onNext(true)
        }
        
    }
    
    func deleteModelInfo(_ index : Int){
        let model = realm.objects(MemoDetailObject.self)[index]
        
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func pushAddViewCon(){
        let viewCon = MemoAddViewController.init(delegate: self)
        parent?.present(viewCon, animated: true, completion: nil)
    }
    
    func pushDetailViewCon(_ model : MemoDetailObject){
        print("💙model : \(model.title)")
        let viewCon = MemoAddViewController.init(delegate: self,
                                                 model: model)
        parent?.present(viewCon, animated: true, completion: nil)
    }
    
}

extension MemoMainViewModel : MemoAddViewControllerDelegate{
    func didPressSaveBtnPress(title : String, content : String){
        let date = getCurrentDate()
        let data: MemoDetailObject = MemoDetailObject()
        data.title = title
        data.content = content
        data.initialDate = date
        data.lastEditDate = date
        
        try! realm.write {
            realm.add(data)
        }
        
        parent?.dismiss(animated: true, completion: nil)
    }
    
    func didPressSaveBtnPress(title : String, content : String, object: MemoDetailObject) {
        
        let predicate = NSPredicate(format: "initialDate = %@", object.initialDate)
        let newObject = realm.objects(MemoDetailObject.self).filter(predicate).first

        try! realm.write {
            newObject?.title = title
            newObject?.content = content
            newObject?.lastEditDate = getCurrentDate()
        }
        
        parent?.dismiss(animated: true, completion: nil)
    }
    
    func getCurrentDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HHmmss"
        
        let dateStr = formatter.string(from: Date())
        return dateStr
    }
}

extension MemoMainViewModel : ReactiveCompatible {}

extension Reactive where Base: MemoMainViewModel {
//    var list: Observable<Array<Any>>{
//        return self.base.listModelPublishSubject.asObserver()
//    }
    
    var delete : Observable<Int>{
        return self.base.deletePublishSubject.asObservable() //asObserver()
    }
    
    var isUpdate : Observable<Bool>{
        return  self.base.isUpdatePublishSubject.asObserver()
    }
}
