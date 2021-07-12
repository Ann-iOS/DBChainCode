//
//  HomeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/12.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "库链验证器"
        self.view.backgroundColor = .white
        let leftItem = UIBarButtonItem.init(image: UIImage(named: "home_left_item"), style: .plain, target: self, action: #selector(showLeftMenu(_:)))
        self.navigationItem.leftBarButtonItem = leftItem

        let leftMenu = SideMenuNavigationController(rootViewController: MenuViewController())
        leftMenu.isNavigationBarHidden = true //侧栏菜单不显示导航栏
        SideMenuManager.default.leftMenuNavigationController = leftMenu
    }

    // 显示左侧菜单
    @objc func showLeftMenu(_ sender: Any) {
        // 显示侧栏菜单
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                     completion: nil)
    }

}

extension HomeViewController: SideMenuNavigationControllerDelegate {

    // 侧栏菜单将要显示时触发
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("菜单将要显示! (是否有动画: \(animated))")
    }

    // 侧栏菜单显示完毕时触发
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("菜单显示完成! (是否有动画: \(animated))")
    }

    // 侧栏菜单将要隐藏时触发
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("菜单将要隐藏!(是否有动画: \(animated))")
    }

    // 侧栏菜单隐藏完毕时触发
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print("菜单隐藏完毕!(是否有动画: \(animated))")
    }
}
