//
//  MenuViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/12.
//

import UIKit
import SideMenu
import SnapKit

class MenuViewController: UIViewController {


    lazy var feedbackBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "menu_center_mail"), for: .normal)
        btn.setTitle("发送反馈", for: .normal)
        btn.setTitleColor(.colorWithHexString("000000"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(feedBackButtonClick), for: .touchUpInside)
        return btn
    }()

    lazy var serviceBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("服务条款", for: .normal)
        btn.setTitleColor(.colorWithHexString("666666"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(serviceClick), for: .touchUpInside)
        return btn
    }()

    lazy var policyBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("隐私政策", for: .normal)
        btn.setTitleColor(.colorWithHexString("666666"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(privacyPolicyClick), for: .touchUpInside)
        return btn
    }()


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        let leftItem = UIBarButtonItem.init(image: UIImage(named: "menu_left_item"), style: .plain, target: self, action: #selector(dismissCurrentVC))
        self.navigationItem.leftBarButtonItem = leftItem
        let rightItem = UIBarButtonItem.init(image: UIImage(named: "menu_right_item"), style: .plain, target: self, action: #selector(menuSetting))
        self.navigationItem.rightBarButtonItem = rightItem

        view.addSubViews([feedbackBtn,serviceBtn,policyBtn])
        feedbackBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100 + kNavBarAndStatusBarHeight)
            make.width.height.equalTo(120)
        }
        feedbackBtn.imagePosition(style: .top, spacing: 16)

        serviceBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(feedbackBtn)
            make.bottom.equalTo(policyBtn.snp.top).offset(-50)
            make.width.height.equalTo(policyBtn)
        }

        policyBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-150)
            make.centerX.equalTo(feedbackBtn)
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(30)
        }

    }


    @objc func dismissCurrentVC() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func menuSetting(){
        let vc = SettingViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func feedBackButtonClick(){
        let vc = FeedBackViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func serviceClick() {
        let vc = ServiceClauseViewController()
        vc.type = .service
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func privacyPolicyClick() {
        let vc = ServiceClauseViewController()
        vc.type = .privacy
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
