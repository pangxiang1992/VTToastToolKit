//
//  ViewController.swift
//  VTToastToolKitDemo
//
//  Created by pangxiang on 3/28/18.
//  Copyright © 2018 pangxiang. All rights reserved.
//

import UIKit
import VTToastToolKit
class ViewController: UIViewController {
    var contentView = CartAlertView.loadFromXIB()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        VTToastTool.showPopupView(withContentView: contentView)
    }

}

