//
//  UISliderExtension.swift
//  SDJGVideo
//
//  Created by 王俊 on 16/5/9.
//  Modify  by 王俊 on 17/6/5. swift3.0
//  Copyright © 2016年 sunlands. All rights reserved.
//

import UIKit

extension UISlider {
    
    /**
     添加事件
     
     - parameter target:           目标者
     - parameter actionNames:      方法名
     - parameter forControlEvents: 事件
     */
    public final func extAddTargets(_ target: AnyObject?, actions: [Selector], forControlEvents: [UIControl.Event]){
        
        for i in 0 ..< actions.count{
            
          self.addTarget(target, action: actions[i], for: forControlEvents[i])
            
        }

    }
    
    /**
     设置 按下 拖动 抬起（区域内外） 取消
     
     - parameter target:      目标者
     - parameter actionNames: 事件
     */
    public final func extAddAllTarget(_ target: AnyObject?, actions: [Selector]) {
        
        //1 按下
        self.addTarget(target, action: actions[0], for: UIControl.Event.touchDown)
        //2 拖动
        self.addTarget(target, action: actions[1], for: UIControl.Event.valueChanged)
        
        //3 抬起 区域内抬起 区域外抬起 被取消（电话呼入）
        self.addTarget(target, action: actions[2], for: UIControl.Event.touchUpOutside)
        self.addTarget(target, action: actions[3], for: UIControl.Event.touchCancel)
        self.addTarget(target, action: actions[4], for: UIControl.Event.touchUpInside)
        
    }
    
    
    

}
