//
//  FeedBackViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit
import SVProgressHUD

class FeedBackViewController: BaseViewController, UITextViewDelegate {

    lazy var feedTextView : UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.delegate = self
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 18)
        return view
    }()

    let tipStr = "有反馈意见?我们非常期待收到您的宝贵意见,但请勿透露敏感信息。如有疑问或法律方面的问题,请访问帮助中心或与支持团队联系。"
    let tLabel = UILabel.init()
    let tipLabel = UILabel.init()
    let backView = UIView.init()
    let seatLabel = UILabel.init()
    let sendBtn = UIButton.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "反馈"
        setup()
    }

    func setup(){
        tipLabel.text = "发送反馈"
        tipLabel.textColor = .black
        tipLabel.font = UIFont().themeHNMediumFont(size: 34)

        backView.extSetCornerRadius(8)
        backView.backgroundColor = .colorWithHexString("F7F7F7")

        tLabel.textColor = .colorWithHexString("#ABABAB")
        tLabel.font = UIFont.systemFont(ofSize: 16)
        tLabel.numberOfLines = 0
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: tipStr)

        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, tipStr.count))
        tLabel.attributedText = attributedString
        tLabel.sizeToFit()

        seatLabel.text = "输入建议"
        seatLabel.textColor = .colorWithHexString("ABABAB")
        seatLabel.font = UIFont.systemFont(ofSize: 18)

        sendBtn.setTitle("发送", for: .normal)
        sendBtn.backgroundColor = .colorWithHexString(ThemeMainColor)
        sendBtn.extSetCornerRadius(8)
        sendBtn.titleLabel?.textColor = .white
        sendBtn.titleLabel?.font = UIFont().themeHNMediumFont(size: 18)
        sendBtn.addTarget(self, action: #selector(sendFeedBackText), for: .touchUpInside)

        view.addSubViews([tipLabel,backView,tLabel,sendBtn])
        backView.addSubViews([feedTextView,seatLabel])

        tipLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
        }
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(tipLabel)
            make.top.equalTo(tipLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(110)
        }
        tLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backView.snp.bottom).offset(20)
            make.width.equalTo(backView)
            make.left.equalTo(backView)
        }

        feedTextView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-20)
        }

        seatLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(26)
            make.left.equalToSuperview().offset(26)
        }

        sendBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH - 40)
            make.bottom.equalToSuperview().offset(-52)
            make.height.equalTo(54)
        }
    }


    @objc func sendFeedBackText(){
        if !self.feedTextView.text!.isBlank {
            SVProgressHUD.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                SVProgressHUD.showSuccess(withStatus: "发送成功")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text!.count == 0 {
            seatLabel.isHidden = false
        } else {
            seatLabel.isHidden = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
