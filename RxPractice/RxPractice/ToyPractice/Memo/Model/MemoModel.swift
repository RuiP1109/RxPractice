//
//  MemoModel.swift
//  RxPractice
//
//  Created by YEEUN on 2020/12/10.
//

import Foundation
import RealmSwift

@objcMembers class MemoDetailObject: Object{
    dynamic var title = ""
    dynamic var content = ""
    dynamic var lastEditDate = ""
    dynamic var initialDate = ""
    
    override static func primaryKey() -> String? {
        return "initialDate"
      }
}
