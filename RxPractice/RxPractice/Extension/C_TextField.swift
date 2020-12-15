//
//  C_TextField.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/09.
//

import UIKit
import RxCocoa
import RxSwift

class C_TextField: UITextField {
    
    @IBInspectable open var radius : CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = radius
        }
    }
    
    var getTextPublishSubject = PublishSubject<String?>()
    var setTextPublishSubject = PublishSubject<String?>()
    
    private var disposeBag = DisposeBag()
    
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
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        if #available(iOS 11.0, *){
            self.smartQuotesType = .no
            self.smartDashesType = .no
            self.smartInsertDeleteType  = .no
        }
        
        bind()

    }
    
    func bind(){
        
//        self.rx.text
//            .subscribe { [weak self] _  in
//                self?.textCheckPublishSubject.onNext(self?.text?.count ?? 0 >= 5 ? true : false)
//            }
        
        getTextPublishSubject.subscribe { text in
            self.text = text
        }.disposed(by: disposeBag)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 0)
    }
}

extension Reactive where Base: C_TextField{
//    var checkTextMinlength: Observable<Bool> {
//        return self.base.textCheckPublishSubject.asObserver()
//    }
}
