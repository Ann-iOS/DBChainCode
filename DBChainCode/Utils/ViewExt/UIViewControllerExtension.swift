//
//  UIViewControllerExtension.swift
//  SDJG
//
//  Created by 王俊 on 16/4/20.
//  Modify  by 王俊 on 17/6/5. swift3.0
//  Copyright © 2016年 sunlands. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /**
     弹出模态视图控制器
     
     - parameter vc:              控制器
     - parameter backgroundColor: 背景色 可不传 有默认值
     - parameter animated:        是否动画 可不传 有默认值 默认无动画
     */
    public final func extShowModalVC(_ vc :UIViewController , backgroundColor :UIColor = UIColor.extRGBA(red: 66.0, green: 66.0, blue: 66.0, alpha: 0.4) , animated :Bool = false){
        
        guard let appDelegate  = UIApplication.shared.delegate else {
            return
        }

        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        if appDelegate.window != nil   {
            appDelegate.window??.rootViewController!.present(vc, animated: animated, completion: {
                    //背景色 透明
                vc.view.backgroundColor  = backgroundColor
                    
            })
        }
        
    }

    
}
