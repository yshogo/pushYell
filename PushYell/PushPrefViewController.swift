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
    
    var numberPicker:UIPickerView = UIPickerView()
    var everyTomePickerDatasource:EveryTimePicker?
    
    var numberToolbar:UIToolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prefTimeTextField.delegate = self
        
        initDataSource()
    }
    
    private func initDataSource(){
        everyTomePickerDatasource = EveryTimePicker()
        numberPicker.dataSource = everyTomePickerDatasource
        numberPicker.delegate = everyTomePickerDatasource
        everyTomePickerDatasource?.textField = prefTimeTextField
        numberPicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150.0)
        
        prefTimeTextField.inputView = numberPicker
        
        //Toolbarの生成
        numberToolbar = UIToolbar(frame: CGRect(x:0,y:self.view.frame.size.height/6,width:self.view.frame.size.width,height:40.0))
        numberToolbar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        numberToolbar.backgroundColor = UIColor.black
        numberToolbar.barStyle = UIBarStyle.black
        numberToolbar.tintColor = UIColor.white

        
        //ToolBarを閉じるボタンを追加
        let myToolBarButton = UIBarButtonItem(title: "完了", style: .bordered, target: self, action: #selector(PushPrefViewController.tappedToolBarBtn))
        myToolBarButton.tag = 1
        numberToolbar.items = [myToolBarButton]
        
        prefTimeTextField.inputAccessoryView = numberToolbar
    }
    
    @objc private func tappedToolBarBtn(sender: AnyObject?) {
        prefTimeTextField.resignFirstResponder()
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
    
    private func getNumner(text:String, delimitter:String) -> Int{
        
        
        return -1
    }
}
