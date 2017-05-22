//
//  MainViewController.swift
//  PushYell
//
//  Created by ShogoYamada on 2017/05/14.
//  Copyright © 2017年 山田尚吾. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: ViewController ,UITextFieldDelegate,UITextViewDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    public func localpush(pushData:LocalPushDataProperty){
        // 通知を使用可能にする設定
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // エラー処理
        }
        
        // 通知自体の設定
        let content = UNMutableNotificationContent()
        
        content.title = NSString.localizedUserNotificationString(forKey: pushData.title!, arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: pushData.message!, arguments: nil)
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "my-notification", content: content, trigger: pushData.trigger)
        
        // 通知を登録
        center.add(request) { (error : Error?) in
            if error != nil {
                // エラー処理
            }
        }
    }
    
    //キーボードを閉じる
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
