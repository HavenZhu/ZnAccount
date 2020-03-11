//
//  ZNSignInViewController.swift
//  Account
//
//  Created by zhuning on 16/12/6.
//  Copyright © 2016年 zhuning. All rights reserved.
//

import UIKit
import LocalAuthentication

let defaultBgColor = UIColor.init(red: 0.1, green: 0.5, blue: 0.9, alpha: 1)

class ZNSignInViewController: UIViewController {
    
    let pressBtnTitleColor = UIColor.init(red: 0.5, green: 0.8, blue: 0.9, alpha: 1)
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnFingerPrint: UIButton!
    
    // MARK: - IBActions
    @IBAction func tapFingerPrintBtn(_ sender: UIButton) {
        // 指纹解锁
        unlockWithFingerPrint()
    }
    
    // MARK: - view controller funciton
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnFingerPrint.layer.cornerRadius = 5
        self.btnFingerPrint.backgroundColor = defaultBgColor
        self.btnFingerPrint.setTitleColor(pressBtnTitleColor, for: .highlighted)

        // 指纹解锁
        unlockWithFingerPrint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - 私有方法
    func unlockWithFingerPrint() {
        // 测试使用
//        self.performSegue(withIdentifier: "showAccountList", sender: nil)
        
        // 指纹解锁
        let context = LAContext()
        let reasonStr = NSLocalizedString("LOGIN_WITH_FINGER_PRINT", comment: "使用指纹登录")
        var authError: NSError? = nil
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonStr, reply: { (success, error) in
                if success {
                    DispatchQueue.main.async(execute: {
                        self.performSegue(withIdentifier: "showAccountList", sender: nil)
                    })
                } else {
                    print("验证失败: \(String(describing: error?.localizedDescription))")
                }
            })
        }
    }
    
}
