//
//  UISegmentedControlExtension.swift
//  SDJGVideo
//
//  Created by 王俊 on 16/5/9.
//  Modify  by 王俊 on 17/6/5. swift3.0
//  Copyright © 2016年 sunlands. All rights reserved.
//

import UIKit

extension UISegmentedControl  {
    
    
    public func extAddBottomLine(_ color :UIColor , moveLineColor : UIColor , selIndex : Int , itemsCount : Int){
        
        
        let bottomLine = UIView()
        bottomLine.extUseAutoLayout()
        bottomLine.backgroundColor = color
        self.addSubview(bottomLine)
        
        let bottomMoveLine = UIView()
        bottomMoveLine.tag = 2000
        bottomMoveLine.backgroundColor = moveLineColor
        bottomMoveLine.extSetCornerRadius(1)
        self.addSubview(bottomMoveLine)
        
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomLine]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["bottomLine" : bottomLine]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomLine(1)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["bottomLine" : bottomLine]))
        
        let width = UIScreen.main.bounds.width / CGFloat(itemsCount)
        
        
        bottomMoveLine.frame = CGRect(x:CGFloat(width * CGFloat(selIndex) + 5 ), y:39 , width:25,height:2)
        
    }
    
    
    public func extMoveBottomLine(_ selIndex: Int , itemsCount : Int){
        
        let v = self.viewWithTag(2000)
        if(v != nil){
            
            let point =  v!.center
            
            self.isUserInteractionEnabled = false
            
            UIView.animate(withDuration: 0.5, animations: {
                v!.center = CGPoint(x: UIScreen.main.bounds.width / CGFloat(itemsCount ) * (CGFloat(selIndex) + 0.5) , y: point.y)
            }, completion: { (bool :Bool) in
                self.isUserInteractionEnabled = true
            })
            
        }
    }
}

extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}
