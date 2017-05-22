//
//  PushPrefViewController.swift
//  PushYell
//
//  Created by ShogoYamada on 2017/05/22.
//  Copyright © 2017年 山田尚吾. All rights reserved.
//

import UIKit

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
    }
}
