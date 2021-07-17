//
//  HomeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/12.
//

import UIKit
import SideMenu
import YBPopupMenu
import SYProgressView
import swiftScan
import Photos
import SVProgressHUD

let uploadCodeTimer = "UPLOADCODETIMER"

class HomeViewController: UIViewController, YBPopupMenuDelegate ,LBXScanViewControllerDelegate {

    /// 列表刷新时间
    var waitTime :CGFloat = 30.0

    let isTimerExistence = MCGCDTimer.shared.isExistTimer(WithTimerName: uploadCodeTimer)

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

    lazy var searchTF : UITextField = {
        let tf = UITextField()
        tf.placeholder = "搜索账号"
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.borderStyle = .none
        tf.backgroundColor = .colorWithHexString("#F7F7F7")
        tf.extSetCornerRadius(8)
        tf.delegate = self
        tf.leftViewMode = .always
        tf.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 16, height: tf.frame.height))
        return tf
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
    var hudLabel = UILabel.init()
    var rightItem = UIButton.init()
    /// 用于 搜索时恢复全部数据
    var tempCodeListArr :[[String:Any]] = []
    var codeListArr :[[String:Any]] = [] {
        didSet {
            if codeListArr.count == 0 {
                self.gressview.isHidden = true
                self.timeLabel.isHidden = true
            } else {
                self.gressview.isHidden = false
                self.timeLabel.isHidden = false
            }
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if FileTools.sharedInstance.isFileExisted(path: codePath) {
            /// 已经存在
            print("++++++++++++++++++++++++++++++")
            let dpathArr = NSArray(contentsOfFile: codePath)
            self.codeListArr = dpathArr as! [[String:Any]]
            print("HomeViewController 数组: \(dpathArr!)")
        } else {
            /// 没有数据
            print("没有数据!!!!")
            self.gressview.isHidden = true
            self.timeLabel.isHidden = true
        }
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
        /// 保存全部数据  搜索清空后恢复
        self.tempCodeListArr = self.codeListArr

        let leftItem = UIBarButtonItem.init(image: UIImage(named: "home_left_item"), style: .plain, target: self, action: #selector(showLeftMenu(_:)))
        self.navigationItem.leftBarButtonItem = leftItem

        rightItem.setImage(UIImage(named: "home_more_item"), for: .normal)
        rightItem.addTarget(self, action: #selector(presentMenu(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightItem)

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
        searchTF.frame = CGRect(x: 16, y: 10, width: SCREEN_WIDTH - 32, height: 60)
        headerView.addSubview(searchTF)
        view.addSubview(tableView)

        addBtn = UIButton.init(frame: CGRect(x: SCREEN_WIDTH - 76, y: SCREEN_HEIGHT - kNavBarAndStatusBarHeight - 108, width: 60, height: 60))
        addBtn!.backgroundColor = .colorWithHexString("0059FF")
        addBtn!.setImage(UIImage(named: "home_add_code"), for: .normal)
        addBtn!.setImage(UIImage(named: "home_add_code"), for: .highlighted)
        addBtn!.extSetCornerRadius(30)
        addBtn!.addTarget(self, action: #selector(addCodeString), for: .touchUpInside)
        view.addSubview(addBtn!)

        /// 弹窗
        hudLabel = UILabel.init(frame: CGRect(x: 55, y: self.view.bounds.size.height - kTabBarHeight - 200, width: SCREEN_WIDTH - 110, height: 54))
        hudLabel.backgroundColor = .black
        hudLabel.text = "复制成功"
        hudLabel.textColor = .white
        hudLabel.textAlignment = .center
        hudLabel.extSetCornerRadius(8)
        hudLabel.isHidden = true
        self.view.addSubview(hudLabel)

        if isTimerExistence == true {
            MCGCDTimer.shared.cancleTimer(WithTimerName: uploadCodeTimer)
        }

        MCGCDTimer.shared.scheduledDispatchTimer(WithTimerName: uploadCodeTimer, timeInterval: 0.01, queue: .main, repeats: true) {[weak self] in
            guard let mySelf = self else {return}
            mySelf.gressview.progress = CGFloat(1 - mySelf.waitTime / 30)
            mySelf.waitTime -= 0.01
            if mySelf.waitTime < 0 {
                var dicArr :[[String:Any]] = []
                if FileTools.sharedInstance.isFileExisted(path: codePath) == true {
                    /// 已经存在  更新数据
                    let pathArr = NSArray(contentsOfFile: codePath)

                    if pathArr?.count ?? 0 > 0  {
                        /// 搜索时 另外保存名称
                        var nameArr :[String] = []
                        let tempArr = pathArr as! [[String:Any]]
                        for (idx,tempDic) in tempArr.enumerated() {
                            /// 刷新Code
                            let data = DBase32().addOTPWithTimerLag(keyStr: tempDic["keyStr"]! as! String)
                            let generator = TOTPGenerator.init(secret: data, algorithm: kOTPGeneratorSHA1Algorithm, digits: 6,period: 30)
                            let code = generator?.generateOTP()
                            if code != nil {
                                let dic :Dictionary<String,Any> = ["name":tempDic["name"] as! String,
                                                                   "keyStr":tempDic["keyStr"] as! String,
                                                                   "index":tempDic["index"] as! String,
                                                                   "code":code!]
                                nameArr.append(tempDic["name"] as! String)
                                dicArr.append(dic)
                            }

                            if idx == tempArr.count - 1 {
                                NSArray(array: dicArr).write(toFile: codePath, atomically: true)
                                /// 保存全部数据
                                mySelf.tempCodeListArr = dicArr
                                /// 过滤搜索框数据
                                if !mySelf.searchTF.text!.isBlank {
                                    mySelf.codeListArr.removeAll()
                                    for tmpDic in dicArr {
                                        let name = tmpDic["name"] as! String
                                        if name.contains(mySelf.searchTF.text!) {
                                            mySelf.codeListArr.append(tempDic)
                                        }
                                    }
                                } else {
                                    mySelf.codeListArr = dicArr
                                }
                            }
                        }
                    }
                }

                mySelf.waitTime = 30 - 0.01
            }
            mySelf.timeLabel.text = "\(Int(mySelf.waitTime) + 1)s"
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.tableView.endEditing(true)
    }

    // 显示左侧菜单
    @objc func showLeftMenu(_ sender: Any) {
        // 显示侧栏菜单
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                     completion: nil)
    }

    // 展示一个弹出菜单
    @objc func presentMenu(_ sender: UIButton) {
        YBPopupMenu.showRely(on: rightItem, titles: ["修改列表","导出账号"], icons: ["home_motify_code","home_export_code"], menuWidth: 180) { (menu) in
            menu?.delegate = self
            menu!.animationManager.duration = 0.1
            menu!.cornerRadius = 8
            menu!.itemHeight = 64
            menu!.arrowDirection = .none
            menu!.arrowPosition = 0
            menu!.tableView.separatorStyle = .none
            menu!.borderColor = .clear
        }
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

        toVc.addCodeWithScanClick = {[weak self] in
            guard let mySelf = self else {return}
            if mySelf.isRightCamera() {
                var style = LBXScanViewStyle()
                style.centerUpOffset = 44
                style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.On
                style.photoframeLineW = 6
                style.photoframeAngleW = 24
                style.photoframeAngleH = 24
                style.isNeedShowRetangle = true

                style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid

                //使用的里面网格图片
                style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")
                let vc = LBXScanViewController()
                vc.scanStyle = style
                vc.scanResultDelegate = self
                vc.title = "扫一扫"
                mySelf.navigationController?.pushViewController(vc, animated: true)

            } else {

                let alertController = UIAlertController(title: "提示",message: "请打开相机权限",preferredStyle: .alert)
                let settingsAction = UIAlertAction(title: "设置", style: .default) { (alertAction) in
                    if let appSettings = NSURL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.openURL(appSettings as URL)
                        }
                    }
                alertController.addAction(settingsAction)
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                mySelf.present(alertController, animated: true, completion: nil)
            }
        }
        self.present(toVc, animated: true, completion: nil)
    }

    
    /// 相机权限
    /// - Returns: 权限状态
    func isRightCamera() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        return authStatus != .restricted && authStatus != .denied
    }

    /// 扫描内容解析
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        if scanResult.strScanned!.count > 0 {
            print("扫描原始数据: \(scanResult.strScanned!)")
            let str = scanResult.strScanned!
            if str.contains("[{"),str.contains("}]") {
                let jsonData :Data = str.data(using: .utf8)!
                do {
                    let arr :[[String:Any]] = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [[String : Any]]
                    var dataArr :[[String:Any]] = []
                    // 数据处理
                    arr.forEach { (dic) in
                        var tempDic : [String:Any] = [:]
                        tempDic["name"] = dic["title"]
                        tempDic["keyStr"] = dic["key"]
                        tempDic["code"] = dic["code"]
                        tempDic["index"] = "0"
                        dataArr.append(tempDic)
                    }
                    if FileTools.sharedInstance.isFileExisted(path: codePath) {
                        /// 已经存在
                        let dpathArr :[[String:Any]] = NSArray(contentsOfFile: codePath) as! [[String : Any]]
                        dpathArr.forEach { (dic) in
                            dataArr.append(dic)
                        }
                    }
                    NSArray(array: dataArr).write(toFile: codePath, atomically: true)
                    self.codeListArr = dataArr
                } catch {
                    SVProgressHUD.showError(withStatus: "格式错误")
                }
            }

        } else {
            SVProgressHUD.showError(withStatus: "格式错误")
        }
    }

    func ybPopupMenu(_ ybPopupMenu: YBPopupMenu!, didSelectedAt index: Int) {
        if index == 0 {
            let vc = ModifyListViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = ExportCodeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: SideMenuNavigationControllerDelegate ,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        /// 过滤展示
        var filterArr :[[String:Any]] = []
        if textField.text!.isBlank {
            /// 展示全部
            self.codeListArr = self.tempCodeListArr
        } else {
            for dic in self.tempCodeListArr {
                let name = dic["name"] as! String
                if name.contains(self.searchTF.text!) {
                    filterArr.append(dic)
                }
            }
            self.codeListArr = filterArr
        }
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.codeListArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:HomeListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: HomeListTableViewCell.identifier, for: indexPath) as? HomeListTableViewCell

        if cell == nil {
            cell = HomeListTableViewCell.init(style: .default, reuseIdentifier: HomeListTableViewCell.identifier)
        }
        cell?.selectionStyle = .none
        cell?.titleLabel.text = self.codeListArr[indexPath.row]["name"] as? String
        cell?.codeLabel.text = self.codeListArr[indexPath.row]["code"] as? String
        cell?.HomeListCopyCodeWithCellBlock = { [weak self] (cell:HomeListTableViewCell) in
            guard let mySelf = self else {return}
            let index = tableView.indexPath(for: cell)
            let copyStr = mySelf.codeListArr[index!.row]["code"] as? String
            UIPasteboard.general.string = copyStr
            UIView.animate(withDuration: 0.5) {
                mySelf.hudLabel.isHidden = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                mySelf.hudLabel.isHidden = true
            }
        }
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
