//
//  TF_ButtonView.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/02.
//

import UIKit
import RxCocoa
import RxSwift

class TF_ButtonView: UIView, NibLoadable {

    @IBOutlet weak var mTextField: UITextField!
    @IBOutlet weak var mConfirmBtn: UIButton!
    
    private var disposeBag = DisposeBag()
    var tapConfirmBtnPublishSubject = PublishSubject<String?>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupNib()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupNib() {
        guard let view = loadViewFromNib() else { return }
        
        self.addSubview(view)
        bind()
    }

    func bind(){
        mConfirmBtn.rx.tap
            .subscribe { [weak self] _ in
                self?.tapConfirmBtnPublishSubject.onNext(self?.mTextField.text ?? "")
                self?.mTextField.text?.removeAll()
            }
    }
    
}

extension Reactive where Base: TF_ButtonView{
    var tapConfirmBtn: Observable<String?> {
        return self.base.tapConfirmBtnPublishSubject.asObserver()
    }
}
