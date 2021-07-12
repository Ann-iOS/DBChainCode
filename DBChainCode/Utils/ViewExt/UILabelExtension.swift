//
//  UILabelExtension.swift
//  SDJG
//
//  Created by 王俊 on 16/4/19.
//  Modify  by 王俊 on 17/6/5. swift3.0
//  Copyright © 2016年 sunlands. All rights reserved.
//

import UIKit

extension UILabel {
    
    /**
     设置颜色 字体大小
     
     - parameter textColor: 字体颜色
     - parameter fontSize:  字体大小
     */
    public final func extSetTextColor(_ textColor : UIColor , fontSize : CGFloat){
        
        self.textColor = textColor;
        self.font = UIFont.systemFont(ofSize: fontSize)
        
    }
    
    /**
     设置颜色 字体大小
     
     - parameter textColor: 字体颜色
     - parameter fontSize:  字体大小
     - parameter textAlignment : 文字对齐方式
     */
    public final func extSetTextColor(_ textColor : UIColor , fontSize : CGFloat , textAlignment : NSTextAlignment , isBold : Bool = false , numberOfLines : Int = 1){
        
        self.textColor = textColor;
        if isBold{
            self.font = UIFont.boldSystemFont(ofSize: fontSize)
        }else{
            self.font = UIFont.systemFont(ofSize: fontSize)
        }
        
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
    }
    
    
    /**
     设置内容 颜色 字体大小
     
     - parameter text:      内容
     - parameter textColor: 字体颜色
     - parameter fontSize:  字体大小
     */
    public final func extSetText(_ text : String , textColor : UIColor , fontSize : CGFloat){
        
        self.extSetTextColor(textColor, fontSize: fontSize)
        self.text = text;
        
    }
    
    /**
     设置内容 颜色 字体大小 对齐方式
     
     - parameter text:      内容
     - parameter textColor: 字体颜色
     - parameter fontSize:  字体大小
     - parameter textAlignment:  对齐方式
     */
    public final func extSetText(_ text : String , textColor : UIColor , fontSize : CGFloat , textAlignment : NSTextAlignment){
        
        self.extSetText(text, textColor: textColor, fontSize: fontSize)
        self.textAlignment = textAlignment
        
    }
    
    /**
            Label 文字设置下划线
     */
    func underline() {
    
           if let textString = self.text {
    
               let attributedString = NSMutableAttributedString(string: textString)
    
            attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
    
               attributedText = attributedString
    
           }
    
       }


}
