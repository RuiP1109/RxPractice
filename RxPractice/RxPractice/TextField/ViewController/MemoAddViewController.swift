//
//  MemoAddViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/09.
//

import UIKit

class MemoAddViewController: C_ViewController {

    @IBOutlet weak var mTitleField: C_TextField!
    @IBOutlet weak var mTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTitleField.layer.cornerRadius = 30
        mTitleField.lineHeight = 0
        mTextView.layer.cornerRadius = 10

    }

}
