//
//  ZNAddNewAccountTableViewController.swift
//  Account
//
//  Created by zhuning on 16/12/7.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNAddNewAccountTableViewController: UITableViewController {
    
    var accountDetail: ZNAccountInfo?
    var categories = [String]()
    
    // MARK: - IBOutlets
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
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
        
        return cell
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isSaveAccountInfoSuccess()
    }
    
    // MARK: - 私有方法
    func initParameters() {
        self.title = NSLocalizedString("ADD_ACCOUNT", comment: "新增账号")
        
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
