//
//  ZNAccountInfo.swift
//  Account
//
//  Created by zhuning on 16/12/5.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNAccountInfo {
    var belongTo: String
    var username: String
    var password: String
    var note: String?
    
    convenience init?(belongTo: String, username: String, password: String) {
        self.init(belongTo: belongTo, username: username, password: password, note: nil)
    }
    
    init?(belongTo: String, username: String, password: String, note: String?) {
        self.belongTo = belongTo
        self.username = username
        self.password = password
        self.note = note
        
        if belongTo.isEmpty || username.isEmpty || password.isEmpty {
            return nil
        }
    }
}
