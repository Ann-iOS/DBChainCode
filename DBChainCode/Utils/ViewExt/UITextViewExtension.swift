//
//  UITextViewExtension.swift
//  SDJGVideo
//
//  Created by 王俊 on 16/5/10.
//  Modify  by 王俊 on 17/6/5. swift3.0
//  Copyright © 2016年 sunlands. All rights reserved.
//

import UIKit

extension UITextView {
    public final func extSelectRange() -> NSRange {
        let beginning = self.beginningOfDocument
        let selectedRange = self.selectedTextRange
        let selectionStart = selectedRange!.start
        let selectionEnd = selectedRange!.end
    
        let location: NSInteger = self.offset(from: beginning, to: selectionStart)
        let length: NSInteger = self.offset(from: selectionStart, to: selectionEnd)
        
        return NSMakeRange(location, length)
    }
    
    public func extSetSelectRange(_ range: NSRange) -> Void {
        let beginning = self.beginningOfDocument
        
        let startPosition = self.position(from: beginning, offset:  range.location + range.length)
        let endPosition = self.position(from: beginning, offset:  range.location + range.length)
    
        if startPosition != nil && endPosition != nil {
            let selectionRange = self.textRange(from: startPosition!, to: endPosition!)

            self.selectedTextRange = selectionRange
        } else {
            
        }
        
    }
}
