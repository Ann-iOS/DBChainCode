//
//  DeleteCodeHUDViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/16.
//

import UIKit

enum DeleteType {
    /// 全部
    case All
    /// 单个
    case Alone
}

typealias DeleteSuccessBlock = () -> ()

class DeleteCodeHUDViewController: UIViewController {

    var deleteSuccessBlock :DeleteSuccessBlock?

    /// 默认删除全部
    var type : DeleteType = .Alone

    var deleteCodeName: String = "" {
        didSet {
            centerTipLabel.text = "您确定要移除账号「\(deleteCodeName)」吗?"
        }
    }

    lazy var centerView : UIView = {
        let view = UIView()
        view.extSetCornerRadius(8)
        view.backgroundColor = .white
        return view
    }()

    lazy var tipLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont().themeHNMediumFont(size: 22)
        return label
    }()

    lazy var tipImageV :UIImageView  = {
        let imgV = UIImageView()
        return imgV
    }()

    lazy var centerTipLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 2
        return label
    }()

    lazy var cancelBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(cancelVC), for: .touchUpInside)
        return btn
    }()

    lazy var fixBtn : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(fixButtonClick), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .colorWithHexString("000000", alpha: 0.5)
        view.addSubview(centerView)
        centerView.addSubViews([tipLabel,tipImageV,centerTipLabel,cancelBtn,fixBtn])

        centerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(SCREEN_WIDTH - 76)
            make.height.equalTo(340)
        }

        tipLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(26)
            make.top.equalToSuperview().offset(24)
        }
        tipImageV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.width.height.equalTo(80)
        }
        centerTipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipImageV.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }

        cancelBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(85)
            make.width.equalTo((SCREEN_WIDTH - 76) * 0.5)
        }

        fixBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.height.equalTo(cancelBtn)
        }

        if self.type == .All {
            fixBtn.setTitle("重置", for: .normal)
            fixBtn.setTitleColor(.red, for: .normal)
            tipLabel.text = "重要提示"
            tipImageV.image = UIImage(named: "delete_all_code")
            let tipStr = NSMutableAttributedString(string: "您确定要重置DBChain Usage ID吗？重置将清空全部账号。")
            tipStr.addAttributes([.foregroundColor:UIColor.red], range: NSRange(location: 27, length: 2))
            centerTipLabel.attributedText = tipStr
        } else {
            tipImageV.image = UIImage(named: "delete_alone_code")
            tipLabel.text = "提示"
            fixBtn.setTitle("确定", for: .normal)
            fixBtn.setTitleColor(.black, for: .normal)
        }
    }
    

    @objc func cancelVC() {
        self.dismiss(animated: false, completion: nil)
    }

    @objc func fixButtonClick(){
        if self.type == .All {
            // 删除全部
            NSArray(array: NSArray.init()).write(toFile: codePath, atomically: true)
            self.dismiss(animated: false) {
                if self.deleteSuccessBlock != nil {
                    self.deleteSuccessBlock!()
                }
            }
        } else {
            /// 删除单个
            if FileTools.sharedInstance.isFileExisted(path: codePath) {
                /// 已经存在
                let dpathArr = NSArray(contentsOfFile: codePath)
                var tempArr = dpathArr as! [[String:Any]]
                for (idx,dic) in tempArr.enumerated() {
                    if dic["name"] as! String == self.deleteCodeName {
                        tempArr.remove(at: idx)
                    }
                }
                NSArray(array: tempArr).write(toFile: codePath, atomically: true)
                self.dismiss(animated: false) {
                    if self.deleteSuccessBlock != nil {
                        self.deleteSuccessBlock!()
                    }
                }
            }
        }
    }
}
