//
//  ZNAccountInfo.swift
//  Account
//
//  Created by zhuning on 16/12/5.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNAccountInfo {
    var ID: Int
    var belongTo: String
    var username: String
    var password: String
    var note: String?
    
    convenience init?(belongTo: String, username: String, password: String) {
        self.init(ID: -1, belongTo: belongTo, username: username, password: password, note: nil)
    }
    
    convenience init?(belongTo: String, username: String, password: String, note: String?) {
        self.init(ID: -1, belongTo: belongTo, username: username, password: password, note: note)
    }
    
    init?(ID: Int, belongTo: String, username: String, password: String, note: String?) {
        self.ID = ID
        self.belongTo = belongTo
        self.username = username
        self.password = password
        self.note = note
        
        if belongTo.isEmpty || username.isEmpty || password.isEmpty {
            return nil
        }
    }
}
