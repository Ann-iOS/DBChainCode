//
//  PrivacyFaceIDViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit

class PrivacyFaceIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "隐私保护屏幕"
        self.view.backgroundColor = .white
        setup()
    }

    func setup(){
        let tipleftLabel = UILabel.init()
        tipleftLabel.textColor = .black
        tipleftLabel.text = "隐私保护屏幕"
        tipleftLabel.font = UIFont.systemFont(ofSize: 18)

        let switchBtn = UISwitch()
        switchBtn.addTarget(self, action: #selector(clickSwitchButton), for: .valueChanged)
        switchBtn.isOn = false

        let tipStr = "启动隐私屏幕保护后，需要使用Face ID才能访问此应用"
        let tipLabel = UILabel.init()
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

        view.addSubViews([tipleftLabel,switchBtn,tipLabel])

        tipleftLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(26)
            make.top.equalToSuperview().offset(20)
        }

        switchBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(tipleftLabel)
            make.right.equalToSuperview().offset(-24)
        }
        tipLabel.snp.makeConstraints { (make) in
            make.top.equalTo(tipleftLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

    }

    @objc func clickSwitchButton(){
        
    }
}
