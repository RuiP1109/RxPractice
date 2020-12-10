//
//  MemoAddViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/09.
//

import UIKit
import RealmSwift

protocol MemoAddViewControllerDelegate : class{
    func didPressSaveBtnPress(title : String, content : String)
}

class MemoAddViewController: C_ViewController {

    @IBOutlet weak var mTitleField: C_TextField!
    @IBOutlet weak var mTextView: C_TextView!
    
    weak var delegate : MemoAddViewControllerDelegate?

    private lazy var memoMainViewModel = MemoMainViewModel()
    
    init(delegate : MemoAddViewControllerDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTitleField.layer.cornerRadius = 30
        mTitleField.placeholder = "제목 입력"
        mTitleField.lineHeight = 0
        mTextView.layer.cornerRadius = 10

    }
    
    @IBAction func mSaveBtnPressed(_ sender: UIButton) {
        
        let detailData: MemoDetailObject = MemoDetailObject()
        detailData.title = mTitleField.text ?? String(mTextView.text.prefix(5))
        detailData.content = mTextView.text ?? "12345"

        let realm = try! Realm()
        
        try! realm.write {
            realm.add(detailData)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension MemoAddViewController : MemoAddViewControllerDelegate{
    func didPressSaveBtnPress(title : String, content : String){
        self.delegate?.didPressSaveBtnPress(title: title, content: content)
    }
}
