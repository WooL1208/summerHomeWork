//
//  ViewController.swift
//  summerHomeWork
//
//  Created by WooL on 2020/9/5.
//  Copyright © 2020 WooL. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var locationBtn: UIBarButtonItem!
    @IBOutlet weak var QRCodeBtn: UIBarButtonItem!
    @IBOutlet weak var noticeBtn: UIBarButtonItem!
    @IBOutlet weak var messegeLab: UILabel!
    
    var isLogin = false
    var messegeTimer:Timer!
    var nowMessege = 0
    var userName = ""
    
    let realm = try! Realm()
    
    //可使用Realm代替
    let messege = ["我是訊息1", "我是訊息2", "我是訊息3"]
    let messegeTime = ["2020/3/4", "2020/8/9", "2020/9/5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //demo
//        let demoUser: Users = Users()
//        demoUser.account = "test8898"
//        demoUser.name = "tester"
//        demoUser.passwd = "123456"
//        try! realm.write {
//             realm.add(demoUser)
//        }
        print("fileURL: \(realm.configuration.fileURL!)")
    }
    
    //設定計時器
    override func viewWillAppear(_ animated: Bool) {
        let notificationName = Notification.Name("result")
        NotificationCenter.default.addObserver(self, selector: #selector(getUpdateNoti(noti:)), name: notificationName, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.messegeTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(revoleStart), userInfo: nil, repeats: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.messegeTimer.invalidate()
    }
    
    //設定即時訊息的內容
    @objc func revoleStart() {
        if isLogin == false {
            if nowMessege < messege.count {
                messegeLab.text = messegeTime[nowMessege]+" "+messege[nowMessege]
                nowMessege += 1
            } else {
                nowMessege = 0
                messegeLab.text = messegeTime[nowMessege]+" "+messege[nowMessege]
            }
        } else {
            messegeLab.text = "歡迎 "+userName
        }
    }
    
    //處理登入後傳入的值
    @objc func getUpdateNoti(noti:Notification) {
        isLogin = noti.userInfo!["isPass"] != nil
        userName = noti.userInfo!["isPass"] as! String
        loginBtn.setTitle("登出", for: UIControl.State.normal)
    }
    
    //按下登入/登出按鈕
    @IBAction func loginAct(_ sender: Any) {
        if isLogin == false {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
            isLogin = false
            loginBtn.setTitle("立即登入", for: UIControl.State.normal)
        }
    }
    
    //設定顯示在頁面上的collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 3
        case 1:
            return 9
        default:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exchangeCell", for: indexPath) as! exchengCollectionViewCell
            //設定陰影和邊匡
            cell.cellContentView.layer.shadowOpacity = 0.3
            cell.cellContentView.layer.cornerRadius = 10
            cell.moneyClassView.layer.shadowOpacity = 0.5
            cell.moneyClassView.layer.cornerRadius = 25
            cell.moneyClassImg.layer.cornerRadius = 25
            cell.moneyClassImg.layer.shadowOpacity = 0.5
            cell.moneyClassImg.layer.masksToBounds = true
            
            //設定cell的內容
            let title = ["美金","日圓","歐元"]
            let buy = ["29.3608","0.2751","34.6400"]
            let sale = ["29.4680","0.2791","35.0400"]
            cell.moneyClassText.text = title[indexPath.item]
            cell.moneyBuyText.text = String(buy[indexPath.item])
            cell.moneySaleText.text = String(sale[indexPath.item])
            cell.moneyClassImg.image = UIImage(named: "class\(indexPath.item)")
            cell.buy.text = "買進"
            cell.sale.text = "賣出"
            
            return cell
        case 1:
            let title = ["解憂醫務室","帳戶服務","轉帳/換匯","信用卡服務","投資理財","定存/專案","智能客服","繳費/繳稅","個人設定"]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "functionCell", for: indexPath) as! functionCollectionViewCell
                //設定cell的內容
            cell.functionIcon?.image = UIImage(named: "icon\(indexPath.item)")
            cell.functionTitle.text = title[indexPath.item]
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exchangeCell", for: indexPath) as! exchengCollectionViewCell
            return cell
        }
    }
    //按下collectionView功能按鈕跳頁
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isLogin == true {
            if collectionView.tag == 1 {
                performSegue(withIdentifier: "functionSegue\(indexPath.item)", sender: nil)
            }
        } else {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    //設定navigetion上的按鈕
    @IBAction func QRCodeAct(_ sender: Any) {
        performSegue(withIdentifier: "QRcodeSegue", sender: nil)
    }
    @IBAction func locationAct(_ sender: Any) {
        performSegue(withIdentifier: "locationSegue", sender: nil)
    }
    @IBAction func noticeAct(_ sender: Any) {
        if isLogin == true {
                performSegue(withIdentifier: "noticeSegue", sender: nil)
        } else {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
}
