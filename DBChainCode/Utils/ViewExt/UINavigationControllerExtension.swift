//
//  UINavigationControllerExtension.swift
//  SDJG
//
//  Created by sun on 16/8/17.
//  Modify  by 王俊 on 17/6/5. swift3.0
//  Copyright © 2016年 sunland. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    public func getScreenEdgePanGestureRecognizer() -> UIScreenEdgePanGestureRecognizer? {
        if let s = self.view.gestureRecognizers , s.count > 0 {
            for gestureRecognizer in self.view.gestureRecognizers! {
                if gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.classForCoder()){
                    return gestureRecognizer as? UIScreenEdgePanGestureRecognizer
                }
            }
        }
        return nil
    }
    
}


