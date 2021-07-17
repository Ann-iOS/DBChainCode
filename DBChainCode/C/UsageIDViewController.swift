//
//  UsageIDViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit

class UsageIDViewController: UIViewController {

    let tipStr = "DBChain Usage ID是随您的     DBChain产品使用情況信息一起发送的一小段文本,DBChain不会使用此信息来识别您的身份,也不会将其与您的DBChain帐号相关联,而是用来为所有用户改进DBChain产品与服务使用体验。\n\n您的设备会将您的 DBChain产品使用体验信息发送给 DBChain。 DBChain将使用这些信息来改进产品。我们的隐私权政策阐述了我们在使用这些信息的过程中如何保护您的隐私权。"
    lazy var resetBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("DBChain Usage ID重置", for: .normal)
        btn.setTitleColor(.colorWithHexString(ThemeMainColor), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(resetAllCodeClick), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "DBChain Usage ID"
        self.view.backgroundColor = .white
        self.setup()
    }

    func setup(){
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .colorWithHexString("000000")
        titleLabel.font = UIFont.systemFont(ofSize: 17)

        titleLabel.lineBreakMode = .byWordWrapping
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: tipStr)

        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, tipStr.count))
        titleLabel.attributedText = attributedString
        titleLabel.sizeToFit()

        view.addSubview(titleLabel)
        view.addSubview(resetBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(SCREEN_WIDTH - 40)
        }
        resetBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
        }
    }

    @objc func resetAllCodeClick(){
        let alertVC = DeleteCodeHUDViewController()
        alertVC.type = .All
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.deleteSuccessBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        self.present(alertVC, animated: false, completion: nil)
    }
}
