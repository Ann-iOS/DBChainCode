//
//  SettingViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit

class SettingViewController: UIViewController {

    let SettingTableViewIdentifier = "SETTINGCELLID"
    let cellTieleArr:[String] = ["隐私保护屏幕","DBChain Usage ID"]

    lazy var tableView : UITableView = {
        let view = UITableView.init(frame: self.view.frame, style: .plain)
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.rowHeight = 50
        view.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: SettingTableViewIdentifier)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.view.backgroundColor = .white
        view.addSubview(tableView)
    }

}


extension SettingViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTieleArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell :UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: SettingTableViewIdentifier)
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: SettingTableViewIdentifier)
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = cellTieleArr[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            let vc = PrivacyFaceIDViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = UsageIDViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
