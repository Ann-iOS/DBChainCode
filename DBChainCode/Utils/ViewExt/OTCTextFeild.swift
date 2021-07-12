//
//  OTCTextFeild.swift
//  Chainup
//
//  Created by xue on 2018/11/1.
//  Copyright © 2018 zewu wang. All rights reserved.
//

import UIKit

class OTCTextFeild: UITextField {

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x = 12 // 要往右偏多少根据自己需求，改变这个数字就好
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x = 33 // 要往右偏多少根据自己需求，改变这个数字就好
        return rect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.origin.x = 33 // 这个数字与textRect相同
        return rect
    }
    
    
}
