//
//  ViewController.swift
//  MobileRobotDemo
//
//  Created by Janise on 2019/1/30.
//  Copyright © 2019年 Janise. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
class ViewController: UIViewController,clickDelegate {
    func singleClick() {
        print("单击事件")
    }
    
    func doubleClick() {
        print("双击事件")
    }
    
    let button: MoveBtn = MoveBtn()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.button.delegate = self
        self.button.isDockEdge = true
        self.button.isDragable = true
        self.view.addSubview(self.button)
        self.button.snp.makeConstraints({ (make) in
            make.height.width.equalTo(50)
            make.center.equalToSuperview()
        })

    }

}

