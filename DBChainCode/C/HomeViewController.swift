//
//  HomeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/12.
//

import UIKit
import SideMenu
import PopMenu
import SYProgressView

let uploadCodeTimer = "UPLOADCODETIMER"

class HomeViewController: UIViewController, UINavigationControllerDelegate {

    var waitTime :CGFloat = 30.0

    let isTimerExistence = MCGCDTimer.shared.isExistTimer(WithTimerName: uploadCodeTimer)
    var menuVC :PopMenuViewController?
    public var addBtn :UIButton?

    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.extSetTextColor(.colorWithHexString("ABABAB"), fontSize: 18)
        label.font = UIFont.init(name: "Roboto-BoldItalic", size: 18)
        label.textAlignment = .right
        return label
    }()

    lazy var gressview : SYPieProgressView = {
        let view = SYPieProgressView()
        view.backgroundColor = .white
        view.progressColor = .white
        view.defaultColor = .blue
        view.label.isHidden = true
        view.isAnimation = true
        return view
    }()

    lazy var headerView : UIView = {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 80))
        let backView = UIView.init(frame: CGRect(x: 16, y: 10, width: SCREEN_WIDTH - 32, height: 60))
        backView.backgroundColor = .colorWithHexString("F7F7F7")
        backView.extSetCornerRadius(8)
        return view
    }()

    lazy var tableView : UITableView = {
        let view = UITableView.init(frame: self.view.frame, style: .grouped)
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kNavAndTabHeight, right: 0)
        view.register(UINib.init(nibName: "HomeListTableViewCell", bundle: nil), forCellReuseIdentifier: HomeListTableViewCell.identifier)
        return view
    }()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let currentTime = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "ss"
        let date = formatter.string(from: currentTime)
        self.waitTime = CGFloat(30 - Int(date)! % 30)
        self.gressview.progress = CGFloat(1 - self.waitTime / 30)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "库链验证器"
        
        let leftItem = UIBarButtonItem.init(image: UIImage(named: "home_left_item"), style: .plain, target: self, action: #selector(showLeftMenu(_:)))
        self.navigationItem.leftBarButtonItem = leftItem

        let rightItem = UIBarButtonItem.init(image: UIImage(named: "home_more_item"), style: .plain, target: self, action: #selector(presentMenu(_:)))
        self.navigationItem.rightBarButtonItem = rightItem

        let leftMenu = SideMenuNavigationController(rootViewController: MenuViewController())
        leftMenu.isNavigationBarHidden = false //侧栏菜单不显示导航栏
        leftMenu.presentationStyle = .menuSlideIn
        leftMenu.presentationStyle.onTopShadowColor = .white
        leftMenu.menuWidth = SCREEN_WIDTH - 65
        leftMenu.presentationStyle.backgroundColor = .white
        leftMenu.presentationStyle.onTopShadowOpacity = 1
        leftMenu.presentationStyle.presentingEndAlpha = 1
        SideMenuManager.default.leftMenuNavigationController = leftMenu

        tableView.tableHeaderView = headerView
        view.addSubview(tableView)

        addBtn = UIButton.init(frame: CGRect(x: SCREEN_WIDTH - 76, y: SCREEN_HEIGHT - kNavBarAndStatusBarHeight - 108, width: 60, height: 60))
        addBtn!.backgroundColor = .colorWithHexString("0059FF")
        addBtn!.setImage(UIImage(named: "home_add_code"), for: .normal)
        addBtn!.setImage(UIImage(named: "home_add_code"), for: .highlighted)
        addBtn!.extSetCornerRadius(30)
        addBtn!.addTarget(self, action: #selector(addCodeString), for: .touchUpInside)
        view.addSubview(addBtn!)

        if isTimerExistence == true {
            MCGCDTimer.shared.cancleTimer(WithTimerName: uploadCodeTimer)
        }

        MCGCDTimer.shared.scheduledDispatchTimer(WithTimerName: uploadCodeTimer, timeInterval: 0.01, queue: .main, repeats: true) {[weak self] in
            guard let mySelf = self else {return}
            mySelf.gressview.progress = CGFloat(1 - mySelf.waitTime / 30)
            mySelf.waitTime -= 0.01
            if mySelf.waitTime < 0 {
                mySelf.waitTime = 30 - 0.01
            }
            mySelf.timeLabel.text = "\(Int(mySelf.waitTime) + 1)s"
        }
    }

//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if operation == .push{
//            let customAnim = CustomAnimatedTransitioning()
//            customAnim.isPush = true
//            return customAnim
//        } else {
//            return nil
//        }
//    }


    // 显示左侧菜单
    @objc func showLeftMenu(_ sender: Any) {
        // 显示侧栏菜单
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                     completion: nil)
    }

    // 展示一个弹出菜单
    @objc func presentMenu(_ sender: UIButton) {
        let actions = [PopMenuDefaultAction(title: "修改列表", image: UIImage(named: "home_motify_code"), color: .black, didSelect: { (modifyBtn) in

        }),PopMenuDefaultAction(title: "导出账号", image: UIImage(named: "home_export_code"), color: .black, didSelect: { (exportBtn) in

        })]

        menuVC = PopMenuViewController(actions: actions)
        menuVC!.contentFrame = CGRect(x: SCREEN_WIDTH - 204, y: kNavBarAndStatusBarHeight, width: 180, height: 128)
        menuVC!.appearance.popMenuBackgroundStyle = .dimmed(color: .white, opacity: 0.01)
        menuVC!.appearance.popMenuColor.backgroundColor = .solid(fill: .white)
        menuVC!.appearance.popMenuCornerRadius = 8
        self.present(menuVC!, animated: true, completion: nil)
    }

    @objc func addCodeString(){
        let toVc = AddCodeViewController()
        toVc.modalPresentationStyle = .overFullScreen
        toVc.modalTransitionStyle = .crossDissolve
        toVc.addCodeSettingKeyStringBlock = {[weak self] in
            guard let mySelf = self else {return}
            let vc = SettingCodeViewController()
            mySelf.navigationController?.pushViewController(vc, animated: true)
        }
        self.present(toVc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(toVc, animated: true)
    }

}

extension HomeViewController: SideMenuNavigationControllerDelegate ,UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:HomeListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: HomeListTableViewCell.identifier, for: indexPath) as? HomeListTableViewCell

        if cell == nil {
            cell = HomeListTableViewCell.init(style: .default, reuseIdentifier: HomeListTableViewCell.identifier)
        }
        cell?.selectionStyle = .none
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))

        let titleLabel = UILabel.init(frame: CGRect(x: 24, y: 20, width: 200, height: 24))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.text = "     账号列表"
        view.addSubview(titleLabel)

        gressview.frame = CGRect(x: SCREEN_WIDTH - 45, y: 22, width: 22, height: 22)
        gressview.extSetCornerRadius(11)
        view.addSubview(gressview)
        gressview.initializeProgress()

        timeLabel.frame = CGRect(x: gressview.frame.minX - 56, y: gressview.frame.minY, width: 50, height: 24)
        view.addSubview(timeLabel)

        return view
    }


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
