//
//  TF_Btn_LBViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/02.
//

import UIKit

class TF_Btn_LBViewController: C_ViewController {
    
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
                print("💙tapConfirmBtn : \(title)")
                self?.mLabel.text = title
            }
    }

}
