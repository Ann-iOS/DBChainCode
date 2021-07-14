//
//  AddCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit

typealias AddCodeWithSettingKeyBlock = () -> ()

class AddCodeViewController: UIViewController, UINavigationControllerDelegate {

    var addCodeSettingKeyStringBlock :AddCodeWithSettingKeyBlock?

    public var cancelBtn :UIButton?

    lazy var scanBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(named: "add_scan_code"), for: .normal)
        btn.extSetCornerRadius(30)
        btn.addTarget(self, action: #selector(scanBtnClick), for: .touchUpInside)
        return btn
    }()

    lazy var keyBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage(named: "add_code_Secretkey"), for: .normal)
        btn.extSetCornerRadius(30)
        btn.addTarget(self, action: #selector(settingKeyBtnClick), for: .touchUpInside)
        return btn
    }()

    lazy var scanTipLabel : UILabel = {
        let label = UILabel()
        label.text = "扫描二维码"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var keyTipLabel : UILabel = {
        let label = UILabel()
        label.text = "输入设置密钥"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .colorWithHexString("000000", alpha: 0.9)
        cancelBtn = UIButton.init(frame: CGRect(x: SCREEN_WIDTH - 76, y: SCREEN_HEIGHT - 106, width: 60, height: 60))
        cancelBtn!.backgroundColor = .colorWithHexString("0059FF")
        cancelBtn!.setImage(UIImage(named: "add_code_cancel"), for: .normal)
        cancelBtn!.setImage(UIImage(named: "add_code_cancel"), for: .highlighted)
        cancelBtn!.extSetCornerRadius(30)
        cancelBtn!.addTarget(self, action: #selector(cancelCurrentVC), for: .touchUpInside)
        view.addSubview(cancelBtn!)
        view.addSubViews([keyBtn,scanBtn,scanTipLabel,keyTipLabel])

        keyBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(cancelBtn!.snp.top).offset(-33)
            make.centerX.equalTo(cancelBtn!)
            make.width.height.equalTo(60)
        }

        scanBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(keyBtn.snp.top).offset(-20)
            make.centerX.equalTo(cancelBtn!)
            make.width.height.equalTo(60)
        }

        scanTipLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(scanBtn)
            make.right.equalTo(scanBtn.snp.left).offset(-16)
        }

        keyTipLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(keyBtn)
            make.right.equalTo(scanTipLabel)
        }

    }

    @objc func cancelCurrentVC(){
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }

    @objc func scanBtnClick() {

    }

    @objc func settingKeyBtnClick() {
        self.dismiss(animated: false) {
            if self.addCodeSettingKeyStringBlock != nil {
                self.addCodeSettingKeyStringBlock!()
            }
        }
    }


    /// 转场实现
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if operation == .pop{
//            let customAnim = CustomAnimatedTransitioning()
//            customAnim.isPush = false
//            return customAnim
//        } else {
//            return nil
//        }
//    }

}
