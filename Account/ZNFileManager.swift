//
//  ZNFileManager.swift
//  Account
//
//  Created by zhuning on 16/12/12.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNFileManager {
    
    // MARK: - 全局方法，处理document文件夹中存放的账号plist文件
    static func documentFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths[0] as String
    }
    
    static func accountFilePath() -> String {
        let documentPath = documentFilePath().appendingFormat("/accountLists.plist")
        return documentPath
    }
    
    static func getAccountInfo(from tableview: UITableView) -> ZNAccountInfo? {
        var belongTo: String?
        var username: String?
        var password: String?
        var note: String?
        for index in 0..<tableview.numberOfRows(inSection: 0) {
            let cell = tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! ZNAccountDetailTableViewCell
            if let text = cell.tfContent.text, !text.isEmpty {
                if index == 0 {
                    belongTo = text
                } else if index == 1 {
                    username = text
                } else if index == 2 {
                    password = text
                } else if index == 3 {
                    note = text
                }
            } else if index != 3 {
                return nil
            }
        }
        
        return ZNAccountInfo(belongTo: belongTo!, username: username!, password: password!, note: note)
    }
    
    static func createCanNotSaveAlert() -> UIAlertController {
        let alert = UIAlertController.init(title: NSLocalizedString("ADD_ACCOUNT_FAILED", comment: "保存失败"),
                                           message: NSLocalizedString("EMPTY_ACCOUNT_OR_PASSWORD", comment: "账号和密码不能为空"),
                                           preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction.init(title: NSLocalizedString("CONFIRM", comment: "确定"),
                                               style: UIAlertActionStyle.default,
                                               handler: nil)
        alert.addAction(confirmAction)
        
        return alert
    }

}
