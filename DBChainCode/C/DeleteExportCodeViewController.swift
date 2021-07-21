//
//  DeleteExportCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/16.
//

import UIKit

class DeleteExportCodeViewController: BaseViewController {

    let imgV = UIImageView(image: UIImage(named: "delete_alone_code"))
    let tipLabel = UILabel.init()
    let centerTipLabel = UILabel.init()
    let removeAllBtn = UIButton.init()
    let defaultBtn = UIButton.init()
    let completeBtn = UIButton.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        tipLabel.text = "建议移除您已导出的账号"
        tipLabel.textColor = .black
        tipLabel.textAlignment = .center
        tipLabel.font = UIFont().themeHNMediumFont(size: 22)

        centerTipLabel.text = "为了安全起见，应将已导出的账号从此设备中移除。将账号从此设备中移除之前，请确保账号已正确导出"
        centerTipLabel.numberOfLines = 0
        centerTipLabel.textColor = .black
        centerTipLabel.font = UIFont.systemFont(ofSize: 16)

        removeAllBtn.setTitle("   移除所有已导出的账号（推荐）", for: .normal)
        removeAllBtn.setImage(UIImage(named: "export_code_nor"), for: .normal)
        removeAllBtn.setImage(UIImage(named: "export_code_sel"), for: .selected)
        removeAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        removeAllBtn.setTitleColor(.black, for: .normal)
        removeAllBtn.tag = 500
        removeAllBtn.addTarget(self, action: #selector(removeAllOrDefailtButton(_:)), for: .touchUpInside)
        removeAllBtn.isSelected = true

        defaultBtn.setTitle("   保留所有已导出的账号", for: .normal)
        defaultBtn.setImage(UIImage(named: "export_code_nor"), for: .normal)
        defaultBtn.setImage(UIImage(named: "export_code_sel"), for: .selected)
        defaultBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        defaultBtn.setTitleColor(.black, for: .normal)
        defaultBtn.tag = 501
        defaultBtn.addTarget(self, action: #selector(removeAllOrDefailtButton(_:)), for: .touchUpInside)
        defaultBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -76, bottom: 0, right: 0)
        defaultBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -72, bottom: 0, right: 0)

        completeBtn.setTitle("完成", for: .normal)
        completeBtn.setTitleColor(.white, for: .normal)
        completeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        completeBtn.backgroundColor = .colorWithHexString(ThemeMainColor)
        completeBtn.extSetCornerRadius(8)
        completeBtn.addTarget(self, action: #selector(completeButtonClick), for: .touchUpInside)

        view.addSubViews([imgV,tipLabel,centerTipLabel,removeAllBtn,defaultBtn,completeBtn])

        imgV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.width.height.equalTo(80)
        }
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imgV.snp.bottom).offset(18)
            make.height.equalTo(30)
        }
        centerTipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }

        removeAllBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(centerTipLabel.snp.bottom).offset(50)
            make.height.equalTo(30)
        }

        defaultBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(removeAllBtn.snp.bottom).offset(28)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }

        completeBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-55)
            make.width.equalTo(160)
            make.height.equalTo(54)
        }
    }

    @objc func removeAllOrDefailtButton(_ sender:UIButton) {
        if sender.tag == 500 {
            removeAllBtn.isSelected = true
            defaultBtn.isSelected = false
        } else {
            removeAllBtn.isSelected = false
            defaultBtn.isSelected = true
        }
    }

    @objc func completeButtonClick() {
        /// 判断删除还是保留
        if self.removeAllBtn.isSelected == true {
            /// 删除所有账号
            NSArray(array: NSArray.init()).write(toFile: codePath, atomically: true)
        }

        let homeVc = HomeViewController.init()
        let nav = BaseNavigationController.init(rootViewController: homeVc)
        UIApplication.shared.keyWindow?.rootViewController = nav
    }
}
