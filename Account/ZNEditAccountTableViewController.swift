//
//  ZNEditAccountTableViewController.swift
//  Account
//
//  Created by zhuning on 16/12/12.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNEditAccountTableViewController: UITableViewController {
    
    var accountDetail: ZNAccountInfo?
    var categories = [String]()
    
    // MARK: - view controller funciton
    override func viewDidLoad() {
        super.viewDidLoad()
        initParameters()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    // MARK: - tableview delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDetailCell", for: indexPath) as! ZNAccountDetailTableViewCell
        
        cell.lbCategory.text = categories[indexPath.row]
        if indexPath.row == 0 {
            cell.tfContent.text = self.accountDetail?.belongTo
        } else if indexPath.row == 1 {
            cell.tfContent.text = self.accountDetail?.username
        } else if indexPath.row == 2 {
            cell.tfContent.text = self.accountDetail?.password
        } else if indexPath.row == 3 {
            cell.tfContent.text = self.accountDetail?.note
        }
        
        return cell
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isSaveAccountInfoSuccess()
    }
    
    // MARK: - 私有方法
    func initParameters() {
        self.title = NSLocalizedString("EDIT_ACCOUNT", comment: "编辑账号")
        
        let path = Bundle.main.path(forResource: "AccountCategory", ofType: "plist")
        let dic = NSDictionary(contentsOfFile: path!) as! Dictionary<String, [String]>;
        categories = dic["edit"]!
    }
    
    func isSaveAccountInfoSuccess() -> Bool {
        if let accountInfo = ZNFileManager.getAccountInfo(from: self.tableView) {
            self.accountDetail = accountInfo
            return true
        } else {
            present(ZNFileManager.createCanNotSaveAlert(), animated: true, completion: nil)
            return false
        }
    }

}
