//
//  C_ViewController.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/07.
//

import UIKit
import RxSwift
import RxCocoa

class C_ViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var titleOffsetY: CGFloat = 50
    var isNavigationBarTitleShow: Bool = false
    
    lazy var navigationBarTitleLabel : UILabel = {
        var titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.alpha = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

extension C_ViewController {
    func setNavigationBarTitle(text: String , offsetY: CGFloat) {
        navigationBarTitleLabel.text = text
        //        navigationBarTitleLabel.sizeToFit()
        titleOffsetY = offsetY
        hideTitle(animated: false)
    }
    
    func navigationBarTitleHandler(offsetY: CGFloat) {
        //        print("offsetY \(offsetY)")
        
        if (offsetY >= titleOffsetY && navigationBarTitleLabel.text?.count ?? 0 > 0) {
            if !self.isNavigationBarTitleShow {
                self.showTitle(animated: true)
            }
        } else {
            if self.isNavigationBarTitleShow {
                self.hideTitle(animated: true)
            }
        }
    }
    
    func showTitle(animated:Bool) {
        self.isNavigationBarTitleShow = true
        
        self.navigationController?.navigationBar.topItem?.titleView = self.navigationBarTitleLabel
        
        UIView.animate(withDuration: animated ? 0.35 : 0, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.navigationBar.topItem?.titleView?.alpha = 1
        }, completion:{ (finished) in
            
        })
    }
    
    func hideTitle(animated:Bool) {
        self.isNavigationBarTitleShow = false

        UIView.animate(withDuration: animated ? 0.35 : 0, delay: 0, options: UIView.AnimationOptions(), animations: {
            self.navigationController?.navigationBar.topItem?.titleView?.alpha = 0
        }, completion:{ (finished) in
            self.navigationController?.navigationBar.topItem?.titleView = nil
        })
    }
}
