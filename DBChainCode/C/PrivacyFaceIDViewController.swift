//
//  PrivacyFaceIDViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit
import TJBioAuthentication

class PrivacyFaceIDViewController: UIViewController {

    var tipStr = "启动隐私屏幕保护后，需要使用Face ID才能访问此应用"

    let tipleftLabel = UILabel.init()
    let tipLabel = UILabel.init()
    let switchBtn = UISwitch(frame: CGRect(x: SCREEN_WIDTH - 24 - 60, y: 20, width: 80, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "隐私保护屏幕"
        self.view.backgroundColor = .white
        setup()
    }

    func setup(){

        if !Device_Is_iPhone_All {
            tipStr = "启动隐私屏幕保护后，需要使用Touch ID才能访问此应用"
        }
        tipleftLabel.textColor = .black
        tipleftLabel.text = "隐私保护屏幕"
        tipleftLabel.font = UIFont.systemFont(ofSize: 18)

        switchBtn.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        if UserDefaults.standard.object(forKey: FaceIDStateKey) as! Int == 1 {
            switchBtn.isOn = true
        } else {
            switchBtn.isOn = false
        }

        tipLabel.numberOfLines = 0
        tipLabel.font = UIFont.systemFont(ofSize: 16)
        tipLabel.textColor = .black
        tipLabel.lineBreakMode = .byWordWrapping
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: tipStr)

        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, tipStr.count))
        tipLabel.attributedText = attributedString
        tipLabel.sizeToFit()

        view.addSubview(switchBtn)
        view.addSubViews([tipleftLabel,tipLabel])

        tipleftLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(26)
            make.top.equalToSuperview().offset(20)
        }

        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tipleftLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

    }

    @objc func switchDidChange(_ sender:UISwitch){
        sender.isOn = !sender.isOn
        /// 打开认证
        if sender.isOn == false {
            TJBioAuthenticator.shared.authenticateUserWithBiometrics(success: {[weak self] in
                guard let mySelf = self else {return}
                mySelf.showSuccessAlert()
            }) { (error) in
                switch error{
                case .biometryLockedout:
                    self.executePasscodeAuthentication()
                    break
                default:
                    self.presentAlert(withTitle: "错误", message: error.getMessage())
                    break
                }
            }
        } else {
            /// 关闭认证
            closeFaceID()
        }
    }

    func executePasscodeAuthentication() {
        TJBioAuthenticator.shared.authenticateUserWithPasscode(success: {
            self.showSuccessAlert()
        }) { (error) in
            self.presentAlert(withTitle: "错误", message: error.getMessage())
        }
    }

    func showSuccessAlert() {
        DispatchQueue.main.async {
            UserDefaults.standard.setValue(1, forKey: FaceIDStateKey)
            self.switchBtn.isOn = true
        }
    }

    func closeFaceID(){
        DispatchQueue.main.async {
            UserDefaults.standard.setValue(0, forKey: FaceIDStateKey)
            self.switchBtn.isOn = false
        }
    }
}
