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
    
    fileprivate var listModelPublishSubject = PublishSubject<Array<Any>>()
    fileprivate var deletePublishSubject = PublishSubject<Int>()
    fileprivate var isUpdatePublishSubject = PublishSubject<Bool>()
    
    fileprivate var realm: Realm!
    fileprivate var notificationToken: NotificationToken?
    
    init() {
        realm = try! Realm()
        bind()
    }
    
    func bind(){
        
//        let item = realm.objects(MemoListObject.self)
        let item = self.getModelInfo()
        self.listModelPublishSubject.onNext(item)
        
        deletePublishSubject
            .subscribe { [weak self] index in
                self?.deleteModelInfo(index)
        }
        
        notificationToken = realm.observe { [unowned self] _, _ in
        }
        
    }
    
    func getModelInfo() -> Array<Any> {
        let model = realm.objects(MemoDetailObject.self)
        return Array(model)
    }
    
    func deleteModelInfo(_ index : Int){
        let model = realm.objects(MemoDetailObject.self)[index]
        
        try! realm.write {
            realm.delete(model)
        }
        
        isUpdatePublishSubject.onNext(true)
    }
    
}

extension MemoMainViewModel : MemoAddViewControllerDelegate{
    func didPressSaveBtnPress(title : String, content : String){
        let data: MemoDetailObject = MemoDetailObject()
        data.title = title
        data.content = content
        
        try! realm.write {
            realm.add(detailData)
        }
    }
}

extension MemoMainViewModel : ReactiveCompatible {}

extension Reactive where Base: MemoMainViewModel {
    var list: Observable<Array<Any>>{
        return self.base.listModelPublishSubject.asObserver()
    }
    
    var delete : Observable<Int>{
        return self.base.deletePublishSubject.asObservable() //asObserver()
    }
    
    var isUpdate : Observable<Bool>{
        return  self.base.isUpdatePublishSubject.asObserver()
    }
}
