//
//  NibLoadable.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/02.
//

import UIKit

protocol NibLoadable {
    associatedtype T = Self
    func loadViewFromNib(name: String) -> T?
}

extension NibLoadable where Self: UIView {
    func loadViewFromNib(name nibName: String) -> T? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? T
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: Self.self), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension NibLoadable where Self: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }
    
    static var identifier: String {
        return String(describing: Self.self)
    }
}
