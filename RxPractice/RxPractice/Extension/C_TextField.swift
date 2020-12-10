//
//  C_TextField.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/09.
//

import UIKit

class C_TextField: UITextField {

    let border = CALayer()
    var maxLength = 100
    var validLength = 100
    
    open var lineColor : UIColor = .lightGray {
        didSet{
            border.borderColor = lineColor.cgColor
        }
    }

    open var selectedLineColor : UIColor = .black {
        didSet{
            border.borderColor = selectedLineColor.cgColor
        }
    }
    
    open var lineHeight : CGFloat = CGFloat(1.0) {
        didSet{
            border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //  some initialisation for init with frame
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI() {
        textContentType = .none
        border.borderColor = lineColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        if #available(iOS 11.0, *){
            self.smartQuotesType = .no
            self.smartDashesType = .no
            self.smartInsertDeleteType  = .no
        }
    }
        
    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width:  self.frame.size.width, height: self.frame.size.height)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        border.borderColor = selectedLineColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        border.borderColor = lineColor.cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 0)
    }
}
