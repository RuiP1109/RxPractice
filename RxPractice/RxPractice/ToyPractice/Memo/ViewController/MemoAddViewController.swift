//
//  MemoAddViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/09.
//

import UIKit
import RealmSwift
import RxSwift

enum MemoAddViewBtnType {
    case add, modify
}

protocol MemoAddViewControllerDelegate : class{
    func didPressSaveBtnPress(title : String, content : String, object : MemoDetailObject)
    func didPressSaveBtnPress(title : String, content : String)
}

class MemoAddViewController: C_ViewController {
    
    @IBOutlet private weak var mTitleField: C_TextField!
    @IBOutlet private weak var mTextView: C_TextView!
    @IBOutlet private weak var mSaveBtn: C_Button!
    
    private var disposeBag = DisposeBag()
    
    private var model : MemoDetailObject?
    weak var delegate : MemoAddViewControllerDelegate?
    
    var type : MemoAddViewBtnType = .add
    
    //    private lazy var memoMainViewModel = MemoMainViewModel(parent: self)
    
    init(delegate : MemoAddViewControllerDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    init(delegate : MemoAddViewControllerDelegate, model : MemoDetailObject) {
        super.init()
        self.delegate = delegate
        self.model = model
        type = .modify
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    func setUI(){
        mSaveBtn.setTitle(type == .add ? "저장" : "수정" , for: .normal)
        
        bind()
        
    }
    
    func bind(){
        mTitleField.getTextPublishSubject
            .onNext(model?.title)
        mTextView.getTextPublishSubject
            .onNext(model?.content)
    }
    
    @IBAction func mSaveBtnPressed(_ sender: UIButton) {
        
        if type == .add{
            didPressSaveBtnPress(title: mTitleField.text ?? String(mTextView.text.prefix(5)),
                                 content: mTextView.text)
        }else{
            if let object = model{
                //여기 rx 적용방법 있는지 확인해보기
                didPressSaveBtnPress(title : mTitleField.text ?? String(mTextView.text.prefix(5)),
                                     content : mTextView.text, object: object)
            }
            
        }
        
    }
    
}

extension MemoAddViewController : MemoAddViewControllerDelegate{
    func didPressSaveBtnPress(title: String, content: String, object: MemoDetailObject) {
        self.delegate?.didPressSaveBtnPress(title: title, content: content, object: object)
    }
    func didPressSaveBtnPress(title : String, content : String){
        self.delegate?.didPressSaveBtnPress(title: title, content: content)
    }
}
