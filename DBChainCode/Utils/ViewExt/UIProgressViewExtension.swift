//
//  UIProgressViewExtension.swift
//  SDJGVideo
//
//  Created by 王俊 on 16/5/9.
//  Modify  by 王俊 on 17/6/5. swift3.0
//  Copyright © 2016年 sunlands. All rights reserved.
//

import UIKit

extension UIProgressView {

    /**
     设置进度色 背景色
     
     - parameter color:          进度色
     - parameter trackTintColor: 背景色
     */
    public final func  extSetProgressTintColor(_ color : UIColor ,  trackColor : UIColor){
        
        self.progressTintColor = color
        self.trackTintColor = trackColor

    }
    
    
    /**
     设置进度图片名字 背景图片名字
     
     - parameter name:           进度图片名字
     - parameter trackImageName: 轨迹图片名字
     */
    public final func extSetProgressImageName(_ name : String , trackImageName : String ){
        
        self.progressImage = UIImage.init(named: name)
        self.trackImage = UIImage.init(named: trackImageName)
        
    }
    
}
