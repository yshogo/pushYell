//
//  HomeViewController.swift
//  PushYell
//
//  Created by ShogoYamada on 2017/05/28.
//  Copyright © 2017年 山田尚吾. All rights reserved.
//

import UIKit

class HomeViewController: MainViewController {

    @IBOutlet weak var setedNotificationTime: UILabel!
    @IBOutlet weak var settingword: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initiarizeSetting()
    }
    
    func initiarizeSetting(){
        let userdefault = UserDefaults.standard
        
        if (userdefault.object(forKey: "notificationTime")) != nil{
            
            setedNotificationTime.text = userdefault.string(forKey: "notificationTime")
        }else{
            setedNotificationTime.text = ""
            settingword.text = ""
            editButton.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
