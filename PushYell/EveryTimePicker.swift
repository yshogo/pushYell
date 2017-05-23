//
//  File.swift
//  PushYell
//
//  Created by ShogoYamada on 2017/05/23.
//  Copyright © 2017年 山田尚吾. All rights reserved.
//

import UIKit
import Foundation

class EveryTimePicker:NSObject,UIPickerViewDelegate,UIPickerViewDataSource{
    
    let hour = 24
    let minute = 60
    
    var delegate:UIPickerView?
    var dataSource:UIPickerView?
    
    //pickerの表示列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
    }
    
    /// pickerの表示個数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0{
            return hour
        }
        
        return minute
    }
    
    /// pickerの表示内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0{
            return getPickerText(count: hour)[row]
        }
        
        return getPickerText(count: minute)[row]
    }
    
    //Picker選択時
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("回りました")
    }

    //表示テキストを作成する
    private func getPickerText(count:Int) -> [String]{
        
        var text:Array<String> = []
        
        var i = 1
        for _ in 1...count{
            text.append(String(i))
            i += 1
        }
        
        return text
    }
    
}
