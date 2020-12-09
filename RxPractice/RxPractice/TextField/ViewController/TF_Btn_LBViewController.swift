//
//  TF_Btn_LBViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/02.
//

import UIKit
import RxSwift

class TF_Btn_LBViewController: C_ViewController {
    
    @IBOutlet weak var mSearchView: TF_ButtonView!
    @IBOutlet weak var mLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBarTitle(text: "TF_Btn_Lb", offsetY: 30)
        
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
