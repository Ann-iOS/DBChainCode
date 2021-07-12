//
//  ProgressHVD.swift
//  AppProject
//
//  Created by zewu wang on 2018/8/2.
//  Copyright © 2018年 zewu wang. All rights reserved.
//

import UIKit
import SVProgressHUD
//import JGProgressHUD

public class ProgressHUDManager : NSObject{
    
    static let time = TimeInterval.init(3)
    
    public class func setBackgroundColor(_ color: UIColor) {
        SVProgressHUD.setBackgroundColor(color)
    }
    
    public class func setForegroundColor(_ color: UIColor) {
        SVProgressHUD.setForegroundColor(color)
    }
    
    public class func setFont(_ font: UIFont) {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 16))
    }
    
    public class func showImage(_ image: UIImage?, status: String) {
        
        SVProgressHUD.show((image ?? UIImage(named: "idCard_information"))!, status: status)
    }
    
    public class func show() {
        SVProgressHUD.show()
    }
    
    public class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    public class func setMinimumDismissTimeInterval(_ delay : TimeInterval){
        SVProgressHUD.setMinimumDismissTimeInterval(delay)
    }

    public class func setDefaultMaskType(_ type: SVProgressHUDMaskType){
        SVProgressHUD.setDefaultMaskType(type)
    }

    public class func showWithStatus(_ status: String?) {
        SVProgressHUD.show(withStatus: status)
    }
    
    public class func isVisible() -> Bool {
        return SVProgressHUD.isVisible()
    }
    
    public class func loading(_ string : String = ""){
        SVProgressHUD.setBackgroundColor(UIColor.colorWithHexString(ThemeMainColor))
        SVProgressHUD.setForegroundColor(UIColor.colorWithHexString(ThemeMainColor))
        SVProgressHUD.show(UIImage.init(named: "loading") ?? UIImage.init(), status: "")
    }
    
//    public class func showSuccessWithStatus(_ string: String) {
//        ProgressHUDManager.showImage(UIImage(named: "HUD_Success"), status: string)
////        EXAlert.showSuccess(msg: string)
//        XHUDManager.sharedInstance.dismissWithDelay {
//        }
//    }
//
//    public class func showFailWithStatus(_ string : String){
//        ProgressHUDManager.showImage(UIImage(named: "Recycler_DeleteTip"), status: string)
////        EXAlert.showFail(msg: string)
//        XHUDManager.sharedInstance.dismissWithDelay {
//        }
//    }
//
    public class func showProgress(_ progress: Float) {
        SVProgressHUD.showProgress(progress)
    }
    
    public class func showProgress(_ progress: Float,status:String) {
        SVProgressHUD.showProgress(progress, status: status)
//
    }
//
//    public class func showErrorWithStatus(_ string: String) {
//        ProgressHUDManager.showImage(UIImage(named: "Recycler_DeleteTip"), status: string)
////        EXAlert.showFail(msg: string)
//        XHUDManager.sharedInstance.dismissWithDelay {
//        }
////
//    }
    
    public class func showSuccessWithStatus(_ string: String!, maskType: SVProgressHUDMaskType) {
        SVProgressHUD.showSuccess(withStatus: string)
        SVProgressHUD.setDefaultMaskType(maskType)
        
    }
    
//    public class func showErrorWithStatus(_ string: String, maskType: SVProgressHUDMaskType) {
//        ProgressHUDManager.showImage(nil, status: string)
////        EXAlert.showFail(msg: string)
//        XHUDManager.sharedInstance.dismissWithDelay {
//        }
//    }
    
    public class func showWithStatus(_ status: String!, maskType: SVProgressHUDMaskType) {
//        ProgressHUDManager.showImage(nil, status: status)
        SVProgressHUD.show(withStatus: status)
        SVProgressHUD.setDefaultMaskType(maskType)
        
    }
    
    public class func showStatus(_ status: String!, maskType: SVProgressHUDMaskType) {
        SVProgressHUD.show(withStatus: status, maskType: maskType)
    }
    
    public class func showStatusWithTime(_ status: [String], maskType: SVProgressHUDMaskType){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            
        }
    }

    public class func dismissWithDelay(_ f : @escaping (() -> ())){
        SVProgressHUD.dismiss(withDelay: 0) {
            f()
        }
    }
    
}

