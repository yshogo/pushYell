//
//  PushPrefViewController.swift
//  PushYell
//
//  Created by ShogoYamada on 2017/05/22.
//  Copyright © 2017年 山田尚吾. All rights reserved.
//

import UIKit
import UserNotifications
import Social

class PushPrefViewController: MainViewController {
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var prefTimeTextField: UITextField!
    @IBOutlet weak var setedTimeTextView: UILabel!
    
    var numberPicker:UIPickerView = UIPickerView()
    var everyTomePickerDatasource:EveryTimePicker?
    
    var numberToolbar:UIToolbar = UIToolbar()
    let userdefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prefTimeTextField.delegate = self
        initDataSource()
        initTexkeyEndToolbar()
        initData()
    }
    
    private func initData(){
        
        if userdefault.object(forKey: "notificationTime") != nil{
            messageTextView.text = userdefault.string(forKey: "message")
            prefTimeTextField.text = userdefault.string(forKey: "notificationTime")
        }
    }
    
    private func initTexkeyEndToolbar(){
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        toolbar.barStyle = UIBarStyle.default
        
        toolbar.sizeToFit()
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
        
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(PushPrefViewController.tappingCommit))
        
        toolbar.items = [spacer , commitButton]
        messageTextView.inputAccessoryView = toolbar
    }
    
    func tappingCommit(){
        self.view.endEditing(true)
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
        
        guard prefTimeTextField.text != "" || messageTextView.text != "" else {
            
            validationError()
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
        
        //ローカルに設定された時間を設定する
        userdefault.set(prefTimeTextField.text,forKey: "notificationTime")
        userdefault.set(messageTextView.text,forKey:"message")
        
        let okAction = UIAlertAction(title: "はい", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            self.tweet()
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
    
    
    func tweet(){
        
        //ツイート可能かどうかチェック
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            
            let slc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            slc?.setInitialText("できていますかPushYellアプリテスト")
            
            //ツイート画面表示
            present(slc!, animated: true, completion: {
            })
            
            slc?.completionHandler = {
                (result:SLComposeViewControllerResult) -> () in
                switch result {
                case SLComposeViewControllerResult.done:
                    
                    print("ツイートしたよ")
                    self.backHomeViewController()
                case SLComposeViewControllerResult.cancelled:
                    
                    print("キャンセルしたよ")
                    self.backHomeViewController()
                }
            }
        }else{
            print("ツイートできませんでした")
        }
    }
    
    private func backHomeViewController(){
        
        let navigetionViewCotroller = self.navigationController!
        let infoViewController = navigetionViewCotroller.viewControllers[navigetionViewCotroller.viewControllers.count - 2] as! HomeViewController
        
        infoViewController.initiarizeSetting()
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    private func validationError(){
    
        let okAction = UIAlertAction(title: "ok", style: .default, handler:{
            (action:UIAlertAction) -> Void in
            
        })
        
        alert(title: "エラー", messageText: "日付もしくは通知時間が設定されていません", okActition: okAction)
        
    }
}
