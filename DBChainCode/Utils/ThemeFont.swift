//
//  ThemeFont.swift
//  DBChain
//
//  Created by iOS on 2020/11/2.
//

import Foundation
import UIKit

extension UIFont {
    public struct ThemeFont {
        public static var H1Medium :UIFont { return UIFont.systemFont(ofSize: 28, weight:.medium)}
        public static var H1Bold :UIFont { return UIFont.systemFont(ofSize: 28, weight:.bold)}
        public static var H2Medium :UIFont { return UIFont.systemFont(ofSize: 24, weight:.medium)}
        public static var H2Bold :UIFont { return UIFont.systemFont(ofSize: 24, weight:.bold)}
        public static var H3Bold :UIFont { return UIFont.systemFont(ofSize: 18, weight:.bold)}
        public static var H3Medium :UIFont { return UIFont.systemFont(ofSize: 18, weight:.medium)}
        public static var H3Regular :UIFont { return UIFont.systemFont(ofSize: 18, weight:.regular)}
        public static var HeadRegular :UIFont { return UIFont.systemFont(ofSize: 16, weight:.regular)}
        public static var HeadMedium :UIFont { return UIFont.systemFont(ofSize: 16, weight:.medium)}
        public static var HeadBold :UIFont { return UIFont.systemFont(ofSize: 16, weight:.bold)}
        public static var BodyRegular:UIFont { return UIFont.systemFont(ofSize: 14, weight:.regular)}
        public static var BodyBold :UIFont { return UIFont.systemFont(ofSize: 14, weight:.bold)}
        public static var BodyBoldTalic : UIFont{return UIFont.init(name: "Arial-BoldItalicMT", size: 14) ?? UIFont.boldSystemFont(ofSize: 14)}
        public static var SecondaryBold:UIFont { return UIFont.systemFont(ofSize: 12, weight:.bold)}
        public static var SecondaryRegular :UIFont { return UIFont.systemFont(ofSize: 12, weight:.regular)}
        public static var SecondaryMinimum:UIFont { return UIFont.systemFont(ofSize: 12, weight:.medium)}
        public static var MinimumRegular:UIFont { return UIFont.systemFont(ofSize: 10, weight:.medium)}
        public static var MinimumBold :UIFont { return UIFont.systemFont(ofSize: 10, weight:.bold)}
    }
    
}

extension NSObject {
    func themeHNFont(size:CGFloat) -> UIFont{
        if let hnFont = UIFont.init(name: "HelveticaNeue", size: size) {
            return hnFont
        }else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    func themeHNBoldFont(size:CGFloat)  -> UIFont{
        if let hnFont = UIFont.init(name: "HelveticaNeue-Bold", size: size) {
            return hnFont
        }else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    func themeHNMediumFont(size:CGFloat)  -> UIFont{
        if let hnFont = UIFont.init(name: "HelveticaNeue-Medium", size: size) {
            return hnFont
        }else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    func themeHNBoldItalicFont(size:CGFloat)  -> UIFont{
        if let hnFont = UIFont.init(name: "HelveticaNeue-BoldItalic", size: size) {
            return hnFont
        }else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
}
