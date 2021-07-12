//
//  BaseNavigationController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/12.
//

import UIKit

@objcMembers
class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {

    var popDelegate: UIGestureRecognizerDelegate?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar = UINavigationBar.appearance()
        //设置false之后自动下沉navigationBar 高度
        self.navigationBar.isTranslucent = false
        //设置navigationBar的背景色
        navBar.barTintColor = .white
        //设置左右bar的颜色
        navBar.tintColor = UIColor.black
//        // 设置标题的样式
        let attriDic = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor:UIColor.black]
        navBar.titleTextAttributes = attriDic
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            //添加图片
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "nav_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftClick))
            //添加文字
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(leftClick))
        }
        super.pushViewController(viewController, animated: animated)
    }


    //返回上一层控制器
    @objc func leftClick() {
        popViewController(animated: true)
    }

    // MARK: - UINavigationControllerDelegate方法
     func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

         if viewController == self.viewControllers[0] {

             self.interactivePopGestureRecognizer!.delegate = self.popDelegate
         }
         else {
             self.interactivePopGestureRecognizer!.delegate = nil
         }
     }
}
