//
//  MainViewController.swift
//  PushYell
//
//  Created by ShogoYamada on 2017/05/14.
//  Copyright © 2017年 山田尚吾. All rights reserved.
//

import UIKit
import UserNotifications

class MainViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 通知を使用可能にする設定
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // エラー処理
        }
        
        // 通知自体の設定
        let content = UNMutableNotificationContent()
        
        content.title = NSString.localizedUserNotificationString(forKey: "通知タイトル", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "通知するメッセージ", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        // アプリを起動して5秒後に通知を送る
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: "my-notification", content: content, trigger: trigger)
        
        // 通知を登録
        center.add(request) { (error : Error?) in
            if error != nil {
                // エラー処理
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
