//
//  ZNAccountDetailTableViewController.swift
//  Account
//
//  Created by zhuning on 16/12/12.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNAccountDetailTableViewController: ZNAddNewAccountTableViewController {
    
    // MARK: - view controller funciton
    override func awakeFromNib() {
        self.type = "detail"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.accountDetail.belongTo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - tableview delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountDetailCell", for: indexPath) as! ZNAccountDetailTableViewCell
        
        cell.lbCategory.text = self.categories[indexPath.row]
        if indexPath.row == 0 {
            cell.tfContent.text = self.accountDetail.username
        } else if indexPath.row == 1 {
            cell.tfContent.text = self.accountDetail.password
        } else if indexPath.row == 2 {
            cell.tfContent.text = self.accountDetail.note
        }
        
        return cell
    }
    
    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editVC = segue.destination as! ZNEditAccountTableViewController
        editVC.accountDetail = self.accountDetail
    }
    
    // MARK: - unwindToDetail
    @IBAction func unwindToDetail(sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? ZNEditAccountTableViewController {
            self.accountDetail = sourceVC.accountDetail
            ZNDBManager.shared.updateAccountInfo(account: self.accountDetail)
            self.tableView.reloadData()
            self.title = self.accountDetail.belongTo
        }
    }
    

}
