//
//  MobileRobotBtn.swift
//  MobileRobotDemo
//
//  Created by Janise on 2019/1/30.
//  Copyright © 2019年 Janise. All rights reserved.
//

import UIKit
protocol clickDelegate {
    
    /// 单击代理方法
    func singleClick()
    
    /// 双击代理方法
    func doubleClick()
}

class MoveBtn: UIButton {
    
    /// 是否可拖拽
    var isDragable: Bool = false
    
    /// 是否停靠边缘
    var isDockEdge: Bool = false

    /// 拖拽中透明度
    var alphaOfDrag: CGFloat = 0.5
    
    /// 停止拖拽透明度
    var alphaOfNormal: CGFloat = 1
    
    /// 停止拖拽到动画停止的时间间隔
    var timeOfAnimation: TimeInterval = 0.3
    
    /// 记录初始点击位置
    var recordPoint: CGPoint? = nil
    
    /// 靠边距离
    var spacing: CGFloat = 2
    
    /// 设置代理
    var delegate: clickDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBackgroundImage(UIImage(named: "cicrle"), for: .normal)
        self.alpha = self.alphaOfNormal
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //不可拖拽直接退出
        if !self.isDragable {
            return
        }
        //点击获取按钮当前位置point
        self.recordPoint = touches.first?.location(in: self)
        //设置按钮点击和拖拽时的透明度
        self.alpha = self.alphaOfDrag
        //设置点击事件
        if touches.first?.tapCount == 1 {
            self.perform(#selector(singleClick), with: nil, afterDelay: 0.2)
        }else if touches.first?.tapCount == 2 {
            self.perform(#selector(doubleClick))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //添加排除移动时出现二次唤醒单击事件
        if touches.first?.tapCount == 1 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(singleClick), object: nil)            
        }
        //不可拖拽时不允许移动
        if !self.isDragable {
            return
        }
        //偏移量
        let tempPoint: CGPoint = (touches.first?.location(in: self))!
        //计算偏移量
        let offSetX = tempPoint.x - (self.recordPoint?.x)!
        let offSetY = tempPoint.y - (self.recordPoint?.y)!
        self.center = CGPoint(x: self.center.x + offSetX, y: self.center.y + offSetY)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = self.alphaOfNormal
        //设置是否停靠边缘
        if self.isDockEdge && self.superview != nil {
            if let superView = self.superview {
                //设置居中线左右界限
                let superFrame: CGRect = superView.frame
                //设置停靠边缘
                UIView.animate(withDuration: self.timeOfAnimation) {
                    //设置停靠位置（此处只考虑停靠左右边缘，设置距上边缘和下边缘，只存在于现实区域，不考虑其他不显示位置）
                    //水平方向
                    if self.center.x > (superFrame.width/2) {
                        self.frame.origin.x = superFrame.width - self.spacing - self.frame.width
                    } else {
                        self.frame.origin.x = self.spacing
                    }
                    //垂直方向
                    let topY = self.frame.origin.y
                    let underY = self.frame.origin.y + self.frame.height
                    if topY < 64 {
                        self.frame.origin.y = 64
                    }
                    if underY > superFrame.height - 49 {
                        self.frame.origin.y = superFrame.height - self.frame.height - 49
                    }
                }
            }
        }
    }
    
    /// 单击事件
    @objc func singleClick() {
        self.delegate?.singleClick()
    }
    
    /// 双击事件
    @objc func doubleClick() {
        //添加排除双击时出现二次唤醒单击事件
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(singleClick), object: nil)
        self.delegate?.doubleClick()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
