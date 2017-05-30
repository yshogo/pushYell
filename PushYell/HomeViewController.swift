//
//  HomeViewController.swift
//  PushYell
//
//  Created by ShogoYamada on 2017/05/28.
//  Copyright © 2017年 山田尚吾. All rights reserved.
//

import UIKit
import MaterialComponents

class HomeViewController: MainViewController {

    @IBOutlet weak var setedNotificationTime: UILabel!
    @IBOutlet weak var settingword: UILabel!
    @IBOutlet weak var newButton: MDCButton!
    @IBOutlet weak var editButton: MDCButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initiarizeSetting()
    }
    
    //初期設定
    func initiarizeSetting(){
        let userdefault = UserDefaults.standard
        
        if (userdefault.object(forKey: "notificationTime")) != nil{
            
            setedNotificationTime.text = userdefault.string(forKey: "notificationTime")
            newButton.isEnabled = true
            editButton.isEnabled = false
        }else{
            setedNotificationTime.text = ""
            settingword.text = ""
            newButton.isEnabled = true
            editButton.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
