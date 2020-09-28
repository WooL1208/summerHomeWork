//
//  LoginViewController.swift
//  summerHomeWork
//
//  Created by WooL on 2020/9/8.
//  Copyright © 2020 WooL. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftKeychainWrapper
import SafariServices

class LoginViewController: UIViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var accountText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var accountType: UISegmentedControl!
    @IBOutlet weak var hintLab: UILabel!
    @IBOutlet var allView: UIView!
    @IBOutlet weak var beTheMemberBtn: UIButton!
    @IBOutlet weak var forgetPasswdBtn: UIButton!
    
    var isRemember: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountView.layer.cornerRadius = accountView.bounds.height / 2
        nameView.layer.cornerRadius = nameView.bounds.height / 2
        passwordView.layer.cornerRadius = passwordView.bounds.height / 2
        accountView.layer.borderColor = UIColor.gray.cgColor
        nameView.layer.borderColor = UIColor.gray.cgColor
        passwordView.layer.borderColor = UIColor.gray.cgColor
        accountView.layer.borderWidth = 0.5
        nameView.layer.borderWidth = 0.5
        passwordView.layer.borderWidth = 0.5
        loginBtn.layer.cornerRadius = loginBtn.bounds.height / 2
        cancelBtn.layer.cornerRadius = cancelBtn.bounds.height / 2
        loginBtn.layer.shadowOpacity = 0.5
        cancelBtn.layer.shadowOpacity = 0.5
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector (tap))
        tapGesture.numberOfTapsRequired = 1
        allView.addGestureRecognizer(tapGesture)
        
        accountText.text = KeychainWrapper.standard.string(forKey: "accountKey")
        
    }
    
    @objc func tap() {
        accountText.resignFirstResponder()
        nameText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
    @IBAction func accountTypeAct(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            hintLab.text = "請輸入網路/行動銀行 會員代號與密碼"
        } else {
            hintLab.text = "請輸入信用卡會員 會員代號與密碼"
        }
    }
    
    @IBAction func rememberAct(_ sender: Any) {
        if isRemember==false {
            isRemember = true
            self.rememberBtn.setImage(UIImage(named: "check"), for: UIControl.State.normal)
        } else {
            isRemember = false
            self.rememberBtn.setImage(UIImage(named: "withoutCheck"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func loginAct(_ sender: Any) {
        let realm = try! Realm()
//        let viewController = ViewController()
        
        let loginUser = realm.objects(Users.self).filter(String(format:"account='%@'",accountText.text!)).first
        if loginUser != nil {
            if loginUser?.name == nameText.text{
                if loginUser?.passwd == passwordText.text {
                    let userName = loginUser!.name as String
                    let notificationName = Notification.Name("result")
                    NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["isPass":userName])
                    self.navigationController?.popViewController(animated: true)
                    if isRemember == true {
                        KeychainWrapper.standard.set(loginUser!.account, forKey: "accountKey")
                    } else {
                        KeychainWrapper.standard.set("", forKey: "accountKey")
                    }
                } else {
                    self.alert(nowMessage: "理財密碼錯誤")
                }
            } else {
                self.alert(nowMessage: "用戶代號錯誤")
            }
        } else {
            self.alert(nowMessage: "帳號不存在")
        }
    }
    
    @IBAction func cancelAct(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func beTheMemberAct(_ sender: Any) {
        let url = URL(string: "https://servicedesk.skbank.com.tw/CloudDesk/Home/Index")!
        if #available(iOS 9.0, *) { //確保是在 iOS9 之後的版本執行
            let safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: false)
                safariVC.delegate = self
            self.present(safariVC, animated: true, completion: nil)
        } else { // iOS 8 以下的話跳出 App 使用 Safari 開啟
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func forgetPasswdAct(_ sender: Any) {
        let url = URL(string: "https://www.skbank.com.tw")!
        if #available(iOS 9.0, *) { //確保是在 iOS9 之後的版本執行
            let safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: false)
                safariVC.delegate = self
            self.present(safariVC, animated: true, completion: nil)
        } else { // iOS 8 以下的話跳出 App 使用 Safari 開啟
            UIApplication.shared.openURL(url)
        }
    }
    
    func alert(nowMessage:String) {
        let controller = UIAlertController(title: "登入失敗", message: nowMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
