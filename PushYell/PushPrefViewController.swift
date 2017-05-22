//
//  PushPrefViewController.swift
//  PushYell
//
//  Created by ShogoYamada on 2017/05/22.
//  Copyright © 2017年 山田尚吾. All rights reserved.
//

import UIKit
import UserNotifications

class PushPrefViewController: MainViewController {
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var prefTimeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        prefTimeTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onEnter(_ sender: Any) {
        
        let pushData = LocalPushDataProperty()
        pushData.title = "がんばって！"
        pushData.message = messageTextView.text + "をがんばって!"
        pushData.trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(year:2017, month: 5, day: 24), repeats: true)
        
        localpush(pushData: pushData)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
        })
        
        
        self.alert(title: "完了", messageText: "登録しました", okActition: okAction)
        
    }
}
