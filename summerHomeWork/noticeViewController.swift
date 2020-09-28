//
//  noticeViewController.swift
//  summerHomeWork
//
//  Created by WooL on 2020/9/12.
//  Copyright © 2020 WooL. All rights reserved.
//

import UIKit

class noticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var setNoticeIcon: UIBarButtonItem!
    @IBOutlet weak var setNoticeBtn: UIBarButtonItem!
    @IBOutlet weak var editNoticeIcon: UIBarButtonItem!
    @IBOutlet weak var editNoticeBtn: UIBarButtonItem!
    @IBOutlet weak var noticeClassSeg: UISegmentedControl!
    @IBOutlet weak var noticeTable: UITableView!
    @IBOutlet weak var noticeToolBox: UIToolbar!
    
    //目前為測資＋留接口給Realm
    var accountNotice = ["【帳務通知】\n 我是通知1-1", "【帳務通知】\n 我是通知1-2", "【帳務通知】\n 我是通知1-3"]
    var accountNoticeTime = ["2020/03/07 13:52:11","2020/05/03 20:11:45","2020/07/15 08:12:09"]
    var couponNotice = ["【好康通知】\n 我是通知2-1", "【好康通知】\n 我是通知2-2", "【好康通知】\n 我是通知2-3"]
    var couponNoticeTime = ["2020/04/08 12:33:39","2020/06/04 15:22:18","2020/08/16 17:48:19"]
    var nowNotice = [""]
    var nowNoticeTime = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nowNotice = accountNotice
        nowNoticeTime = accountNoticeTime
    }
    
    //通知設定
    @IBAction func setNoticeAct(_ sender: Any) {
        self.setNotice()
    }

    @IBAction func noticeEditAct(_ sender: Any) {
        noticeTable.setEditing(!noticeTable.isEditing, animated: true)
        editNoticeBtn.title = (self.noticeTable.isEditing) ? "完成" : "編輯"
    }
    
    //選擇通知種類
    @IBAction func selectNoticeClass(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            nowNotice = accountNotice
            nowNoticeTime = accountNoticeTime
            self.noticeTable.reloadData()
        } else {
            nowNotice = couponNotice
            nowNoticeTime = couponNoticeTime
            self.noticeTable.reloadData()
        }
    }
    
    //暫時作為生成測試資料
    func setNotice() {
        if noticeClassSeg.selectedSegmentIndex == 0 {
            self.accountNotice.append("【帳務通知】\n 測試新增通知")
            nowNotice = accountNotice
            
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
            let now = dateFormatter.string(from: today)
            
            self.accountNoticeTime.append(now)
            nowNoticeTime = accountNoticeTime
            
            self.noticeTable.reloadData()
            
        } else {
            self.couponNotice.append("【好康通知】\n 測試新增通知")
            nowNotice = couponNotice
            
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY/MM/dd HH:mm:ss"
            let now = dateFormatter.string(from: today)
            
            self.couponNoticeTime.append(now)
            nowNoticeTime = couponNoticeTime
            
            self.noticeTable.reloadData()
        }
    }
    
    //編輯
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case UITableViewCell.EditingStyle.delete:
            if noticeClassSeg.selectedSegmentIndex == 0 {
                self.accountNotice.remove(at: indexPath.row)
                nowNotice = accountNotice
                self.accountNoticeTime.remove(at: indexPath.row)
                nowNoticeTime = accountNoticeTime
            } else {
                self.couponNotice.remove(at: indexPath.row)
                nowNotice = couponNotice
                self.couponNoticeTime.remove(at: indexPath.row)
                nowNoticeTime = couponNoticeTime
            }
            self.noticeTable.reloadData()
        default:
            break
        }
    }
    
    //tableView基本設定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nowNotice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! noticeTableViewCell
        
        cell.noticeTimeLab.text = nowNoticeTime[indexPath.item]
        cell.noticeContentLab.text = nowNotice[indexPath.item]
        
        return cell
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
