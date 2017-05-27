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
        
        guard prefTimeTextField.text != nil else {
            
            let okAction = UIAlertAction(title: "ok", style: .default, handler:{
                (action:UIAlertAction) -> Void in
                
            })
            
            alert(title: "エラー", messageText: "日付が入力されていません", okActition: okAction)
            
            return
        }
        
        
        let pushData = LocalPushDataProperty()
        pushData.title = "がんばって！"
        pushData.message = messageTextView.text + "をがんばって!"
        
        let time = prefTimeTextField.text
        let hour = getHour(text: time!, delimitter: "時")
        let minute = getMinute(text: time!, delimitter: "分")
        
        let conpoments = DateComponents(hour: hour, minute: minute)
        
        pushData.trigger = UNCalendarNotificationTrigger(dateMatching:conpoments, repeats: true)
        
        localpush(pushData: pushData)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
        })
        
        
        self.alert(title: "完了", messageText: "登録しました", okActition: okAction)
        
    }
    
    //時間を取得する
    private func getHour(text:String, delimitter:String) -> Int{
        
        let timeText = text.components(separatedBy: delimitter)
        
        guard let hour = Int(timeText[0]) else {
            return -1
        }
        
        return hour
    }
    
    //分を取得する
    private func getMinute(text:String , delimitter:String) -> Int{
        
        let timeText = text.components(separatedBy: delimitter)[0]
        
        guard let minute = Int(timeText.substring(from: timeText.index(before: timeText.endIndex))) else {
            
            return -1
        }
        
        return minute
    }
}
