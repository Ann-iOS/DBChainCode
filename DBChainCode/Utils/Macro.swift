//
//  swift
//  DBChain
//
//  Created by iOS on 2020/10/27.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let kIs_iphone = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
let kIs_iPhoneX = SCREEN_WIDTH >= 375.0 && SCREEN_HEIGHT >= 812.0 && kIs_iphone
let kStatusBarHeight : CGFloat = kIs_iPhoneX ? 44 : 20
let kNavBarHeight : CGFloat = kIs_iPhoneX ? 68 : 44
let kNavBarAndStatusBarHeight : CGFloat = kIs_iPhoneX ? 88 : 64
let kTabBarHeight : CGFloat = kIs_iPhoneX ? 83 : 49
/*顶部安全区域远离高度*/
let kTopBarSafeHeight : CGFloat = kIs_iPhoneX ? 44 : 0
/*底部安全区域远离高度*/
let kBottomSafeHeight : CGFloat = kIs_iPhoneX ? 34 : 0
/*iPhoneX的状态栏高度差值*/
let kTopBarDifHeight : CGFloat = kIs_iPhoneX ? 24 : 0
/*导航条和Tabbar总高度*/
let kNavAndTabHeight : CGFloat = kNavBarAndStatusBarHeight + kTabBarHeight

let Device_Is_iPhoneX = __CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)

let Device_Is_iPhoneXr = __CGSizeEqualToSize(CGSize.init(width: 828/2, height: 1792/2), UIScreen.main.bounds.size)

let Device_Is_iPhoneXs = __CGSizeEqualToSize(CGSize.init(width: 1125/3, height: 2436/3), UIScreen.main.bounds.size)

let Device_Is_iPhoneXs_Max = __CGSizeEqualToSize(CGSize.init(width: 1242/3, height: 2688/3), UIScreen.main.bounds.size)

let isIphoneX = (Device_Is_iPhoneX || Device_Is_iPhoneXr || Device_Is_iPhoneXs||Device_Is_iPhoneXs_Max)
//判断iPhone12_Mini
let Device_Is_iPhone12_Mini = __CGSizeEqualToSize(CGSize.init(width: 1080/3, height: 2340/3), UIScreen.main.bounds.size)
//判断iPhone12 | 12Pro
let Device_Is_iPhone12 = __CGSizeEqualToSize(CGSize.init(width: 1170/3, height: 2532/3), UIScreen.main.bounds.size)
//判断iPhone12 Pro Max
let Device_Is_iPhone12_ProMax = __CGSizeEqualToSize(CGSize.init(width: 1284/3, height: 2778/3), UIScreen.main.bounds.size)
//x系列，包含x、11、12
let Device_Is_iPhone_All = (isIphoneX||Device_Is_iPhone12_Mini||Device_Is_iPhone12||Device_Is_iPhone12_ProMax)

