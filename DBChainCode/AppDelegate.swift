//
//  AppDelegate.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/12.
//

import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared.enable = true
        SVProgressHUD.setErrorImage(UIImage())
        SVProgressHUD.setImageViewSize(CGSize.zero)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
        if (UserDefaults.standard.object(forKey: FaceIDStateKey) == nil){
            UserDefaults.standard.setValue(0, forKey: FaceIDStateKey)
        }
        let homeVC = HomeViewController()
        let nav = BaseNavigationController.init(rootViewController: homeVC)
        window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
}

