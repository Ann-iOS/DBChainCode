//
//  ExportCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/15.
//

import UIKit

class ExportCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let centerImgV = UIImageView.init(image: UIImage(named: "export_code"))
        view.addSubview(centerImgV)

        let exportCodeLabel = UILabel.init()
        exportCodeLabel.text = "导出账号"
        exportCodeLabel.textColor = .black
        exportCodeLabel.textAlignment = .center
        exportCodeLabel.font = UIFont.systemFont(ofSize: 22)

        let tipStr = "将您的账号转移到另外一台设备。您一次可以导出一个或多个账号"
        let tipLabel = UILabel.init()
        tipLabel.textColor = .black
        tipLabel.numberOfLines = 0
        tipLabel.font = UIFont.systemFont(ofSize: 16)
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: tipStr)

        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, tipStr.count))
        tipLabel.attributedText = attributedString
        tipLabel.sizeToFit()

        let continueBtn = UIButton.init()
        continueBtn.setTitle("继续", for: .normal)
        continueBtn.setTitleColor(.white, for: .normal)
        continueBtn.backgroundColor = .colorWithHexString(ThemeMainColor)
        continueBtn.addTarget(self, action: #selector(continueButtonClick), for: .touchUpInside)
        continueBtn.extSetCornerRadius(8)

        view.addSubViews([exportCodeLabel,tipLabel,continueBtn])

        centerImgV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.width.height.equalTo(200)
        }
        exportCodeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(centerImgV.snp.bottom).offset(6)
        }
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(exportCodeLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        continueBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-55)
            make.width.equalTo(160)
            make.height.equalTo(54)
        }
    }
    
    @objc func continueButtonClick(){
        if UserDefaults.standard.object(forKey: FaceIDStateKey) as! Int == 0 {
            /// 不需要认证
            let vc = ExportSelectCodeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            /// 需要认证
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
        DispatchQueue.main.async {[weak self] in
            guard let mySelf = self else {return}
            UserDefaults.standard.setValue(1, forKey: FaceIDStateKey)
            let vc = ExportSelectCodeViewController()
            mySelf.navigationController?.pushViewController(vc, animated: true)
        }
    }


}
