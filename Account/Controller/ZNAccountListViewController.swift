//
//  ZNAccountListViewController.swift
//  Account
//
//  Created by zhuning on 16/12/6.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit

class ZNAccountListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var selectedIndexPath: IndexPath?
    var accounts = [ZNAccountInfo]()
    var displayAccounts = [ZNAccountInfo]()
    
    // MARK: - IBOutlets
    @IBOutlet weak var accountNameSearchBar: UISearchBar!
    @IBOutlet weak var accountTableView: UITableView!
    
    // MARK: - view controller funciton
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.accountNameSearchBar.delegate = self
        self.accountTableView.delegate = self
        self.accountTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        self.accounts = ZNDBManager.shared.loadAccountInfos()
        self.displayAccounts = self.accounts
        
        filterListWithName(self.accountNameSearchBar.text)
        self.accountTableView.reloadData()
        
        if let indexPath = self.selectedIndexPath {
            self.accountTableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - searchbar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchContent = searchBar.text
        filterListWithName(searchContent)
    }
    
    //MARK: - table view datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayAccounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath)
        cell.textLabel?.text = self.displayAccounts[indexPath.row].belongTo
        
        return cell
    }
    
    //MARK: - table view delegate
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showConfirmAlert(with: indexPath)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAccountDetail",
            let vc = segue.destination as? ZNAccountDetailTableViewController,
            let cell = sender as? UITableViewCell
        {
            let indexPath = self.accountTableView.indexPath(for: cell)
            let row = (self.accounts as NSArray).index(of: self.displayAccounts[(indexPath?.row)!])
            self.selectedIndexPath = IndexPath(row: row, section: 0)
            vc.accountDetail = self.displayAccounts[(indexPath?.row)!]
        }
    }
    
    // MARK: - unwindToDetail
    @IBAction func unwindToAccountList(sender: UIStoryboardSegue) {
        if let sourceVC = sender.source as? ZNAddNewAccountTableViewController {
            ZNDBManager.shared.insertAccountInfo(account: sourceVC.accountDetail)
        }
    }
        
    // MARK: - 私有方法
    func filterListWithName(_ name: String?) {
        if name == nil || (name?.isEmpty)! {
            self.displayAccounts = self.accounts
        } else {
            self.displayAccounts = self.accounts.filter{ ($0.belongTo.contains(name!)) }
        }
        
        self.accountTableView.reloadData()
    }
    
    func showConfirmAlert(with indexPath: IndexPath) {
        let alert = UIAlertController.init(title: NSLocalizedString("CONFIRM_DELETE_ACCOUNT", comment: "确定删除账号吗？"),
                                           message: NSLocalizedString("DELETE_ACCOUNT_REMINDER", comment: "删除后将无法恢复"),
                                           preferredStyle: UIAlertController.Style.alert)
        let confirmAction = UIAlertAction.init(title: NSLocalizedString("CONFIRM", comment: "确定"),
                                               style: UIAlertAction.Style.default,
                                               handler: { (action) in
            ZNDBManager.shared.deleteAccountInfo(account: self.accounts[indexPath.row])
                                                
            let row = (self.accounts as NSArray).index(of: self.displayAccounts[indexPath.row])
            self.displayAccounts.remove(at: indexPath.row)
            self.accounts.remove(at: row)
            DispatchQueue.main.async(execute: {
                self.accountTableView.deleteRows(at: [indexPath], with: .fade)
            })
        })
        let cancelAction = UIAlertAction.init(title: NSLocalizedString("CANCEL", comment: "取消"),
                                              style: UIAlertAction.Style.cancel,
                                              handler:nil)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

}
