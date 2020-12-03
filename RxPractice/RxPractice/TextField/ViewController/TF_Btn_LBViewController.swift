//
//  TF_Btn_LBViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/02.
//

import UIKit
import RxSwift

class TF_Btn_LBViewController: UIViewController {
    
    @IBOutlet weak var mSearchView: TF_ButtonView!
    @IBOutlet weak var mLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        // Do any additional setup after loading the view.
    }
    
    func bind(){
        mSearchView.rx.tapConfirmBtn
            .bind { [weak self] title in
                self?.mLabel.text = title
            }
    }

}
