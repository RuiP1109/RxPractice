//
//  C_TextView.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/10.
//

import UIKit


class C_TextView: UITextView {
    
    @IBInspectable open var inset : CGFloat = 0 {
        didSet{
            self.textContainerInset = UIEdgeInsets.init(top: inset, left: inset, bottom: inset, right: inset)
        }
    }

}
