//
//  ZNDBManager.swift
//  Account
//
//  Created by Lj_Haven on 2017/6/15.
//  Copyright © 2017年 zhuning. All rights reserved.
//

import UIKit

class ZNDBManager {
    
    static let shared = ZNDBManager()
    
    let fileURL:URL
    let database: FMDatabase
    
    let databaseQueue: FMDatabaseQueue
    
    private init() {
        fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Account.db")
        
        database = FMDatabase(url: fileURL)
        
        databaseQueue = FMDatabaseQueue(url: fileURL)
        
        guard database.open() else {
            print("打开数据库失败")
            return
        }
        
        self.createAccountInfoTable()
    }
    
    func closeDB() {
        self.database.close()
    }
    
    // MARK: - 创建账户信息表
    func createAccountInfoTable() {
        databaseQueue.inDatabase({ (db) in
            do {
                try db.executeUpdate("CREATE TABLE IF NOT EXISTS ZNAccountInfo(ID INTEGER PRIMARY KEY AUTOINCREMENT, belongTo TEXT NOT NULL, username TEXT NOT NULL, password TEXT NOT NULL, note TEXT)", values: nil)
            } catch  {
                print("创建账户信息表失败")
            }
        })
        
        databaseQueue.close()
    }
    
    // MARK: - 加载表中的所有账户信息
    func loadAccountInfos() -> [ZNAccountInfo] {
        var accounts: [ZNAccountInfo] = []
        
        databaseQueue.inDatabase({ (db) in
            do {
                
                let ret = try db.executeQuery("SELECT * FROM ZNAccountInfo", values: nil)
                while ret.next() {
                    if let ID = ret.string(forColumn: "ID"), let belongTo = ret.string(forColumn: "belongTo"), let username = ret.string(forColumn: "username"), let password = ret.string(forColumn: "password"), let note = ret.string(forColumn: "note") {
                        
                        accounts.append(ZNAccountInfo.init(ID: Int(ID)!, belongTo: belongTo, username: username, password: password, note: note)!)
                    }
                }
            } catch  {
                print("获取所有的账户信息失败")
            }
        })
        
        databaseQueue.close()
        
        return accounts
    }
    
    // MARK: - 增 删 改
    func insertAccountInfo(account: ZNAccountInfo) {
        databaseQueue.inDatabase { (db) in
            do {
                try db.executeUpdate("INSERT INTO ZNAccountInfo (belongTo, username, password, note) values (?, ?, ?, ?)", values: [account.belongTo, account.username, account.password, account.note ?? ""])
            } catch {
                print("插入用户信息失败")
            }
        }
        
        databaseQueue.close()
    }
    
    func deleteAccountInfo(account: ZNAccountInfo) {
        databaseQueue.inDatabase { (db) in
            do {
                try db.executeUpdate("DELETE FROM ZNAccountInfo WHERE ID = ?", values: [account.ID])
            } catch {
                print("删除一条数据失败")
            }
        }
        
        databaseQueue.close()
    }
    
    func updateAccountInfo(account: ZNAccountInfo) {
        databaseQueue.inDatabase { (db) in
            do {
                try db.executeUpdate("UPDATE ZNAccountInfo SET belongTo = ?, username = ?, password = ?, note = ? WHERE ID = ?", values: [account.belongTo, account.username, account.password, account.note ?? "", account.ID])
            } catch {
                print("更新用户信息失败")
            }
        }
        
        databaseQueue.close()
    }
}
