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
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // エラー処理
            
            print("エラーが発生しました")
        }
        
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "通知テスト", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey:  "できましたか", arguments: nil)
        content.sound = UNNotificationSound.default()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
