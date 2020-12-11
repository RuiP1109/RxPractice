//
//  C_Button.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/10.
//

import UIKit
import RxSwift
import RxCocoa

class C_Button: UIButton {

    @IBInspectable open var radius : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = radius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //  some initialisation for init with frame
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bind()
    }
    
    func bind() {
        
    }
    
}

//extension Reactive where Base: C_Button{
//
//    var tapConfirmBtn: Observable<String?> {
////        return self.base.tapConfirmBtnPublishSubject.asObserver()
//    }
//}
