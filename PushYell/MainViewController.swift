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
        
        content.title = NSString.localizedUserNotificationString(forKey: "明日になりました", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "正常に動作したね！やったね！", arguments: nil)
        content.sound = UNNotificationSound.default()
        
        //日付をトリガーとする
        let trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(year:2017, month: 5, day: 21), repeats: true)
        
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
