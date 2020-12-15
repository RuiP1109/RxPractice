//
//  C_TextView.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/10.
//

import UIKit
import RxCocoa
import RxSwift

class C_TextView: UITextView {
    
    @IBInspectable open var radius : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = radius
        }
    }
    
    var getTextPublishSubject = PublishSubject<String?>()
    var setTextPublishSubject = PublishSubject<String?>()
    
    @IBInspectable open var inset : CGFloat = 0 {
        didSet{
            self.textContainerInset = UIEdgeInsets.init(top: inset, left: inset, bottom: inset, right: inset)
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bind()
    }
    
    func bind(){
        getTextPublishSubject.subscribe { text in
            self.text = text
        }
        
    }

}
