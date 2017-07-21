//
//  ZNAddNewAccountTableViewController.swift
//  Account
//
//  Created by zhuning on 16/12/7.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNAddNewAccountTableViewController: UITableViewController {
    
    var accountDetail = ZNAccountInfo.init(belongTo: "", username: "", password: "")
    var categories = [String]()
    var type = ""
    
    override func awakeFromNib() {
        self.type = "edit"
    }
    
    // MARK: - IBOutlets
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - view controller funciton
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initCategoryWithType(self.type)
        self.title = NSLocalizedString("ADD_ACCOUNT", comment: "新增账号")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    // MARK: - tableview delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDetailCell", for: indexPath) as! ZNAccountDetailTableViewCell
        
        cell.lbCategory.text = categories[indexPath.row]
        
        return cell
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.saveAccountInfo()
    }
    
    // MARK: - 私有方法
    func initCategoryWithType(_ type: String) {
        let path = Bundle.main.path(forResource: "AccountCategory", ofType: "plist")
        let dic = NSDictionary(contentsOfFile: path!) as! Dictionary<String, [String]>
        self.categories = dic[type]!
    }
    
    func saveAccountInfo() -> Bool {
        for index in 0..<self.tableView.numberOfRows(inSection: 0) {
            let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! ZNAccountDetailTableViewCell
            if let text = cell.tfContent.text, !text.isEmpty {
                if index == 0 {
                    self.accountDetail.belongTo = text
                } else if index == 1 {
                    self.accountDetail.username = text
                } else if index == 2 {
                    self.accountDetail.password = text
                } else if index == 3 {
                    self.accountDetail.note = text
                }
            } else if index != 3 {
                present(self.createCanNotSaveAlert(), animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    func createCanNotSaveAlert() -> UIAlertController {
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
