//
//  SettingCodeView.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit
import SVProgressHUD

typealias SettingAddCodeButtonBlock = (_ account:String,_ keyStr: String) -> ()
class SettingCodeView: UIView, UITextFieldDelegate {

    var addCodeButtonBlock:SettingAddCodeButtonBlock?

    lazy var accountTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "账号"
        tf.textColor = .black
        tf.backgroundColor = .colorWithHexString("F7F7F7")
        tf.borderStyle = .none
        tf.font = UIFont().themeHNMediumFont(size: 18)
        tf.extSetCornerRadius(8)
        let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.height))
        tf.leftViewMode = .always
        tf.leftView = leftView
        tf.delegate = self
        tf.tag = 300
        return tf
    }()

    lazy var keyTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "密钥"
        tf.textColor = .black
        tf.backgroundColor = .colorWithHexString("F7F7F7")
        tf.borderStyle = .none
        tf.keyboardType = .asciiCapable
        tf.font = UIFont().themeHNMediumFont(size: 18)
        tf.extSetCornerRadius(8)
        let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.height))
        tf.leftViewMode = .always
        tf.leftView = leftView
        tf.delegate = self
        tf.tag = 301
        return tf
    }()

    lazy var addAccountBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("添加", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont().themeHNMediumFont(size: 18)
        btn.backgroundColor = .colorWithHexString(ThemeMainColor)
        btn.extSetCornerRadius(8)
        btn.addTarget(self, action: #selector(addAccountBtnClick), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        let tipLabel = UILabel.init(frame: CGRect(x: 16, y: 20, width: SCREEN_WIDTH - 32, height: 100))
        tipLabel.text = "库链验证器\nDBChain Validator"
        tipLabel.numberOfLines = 0
        tipLabel.textColor = .colorWithHexString("000000")
        tipLabel.font = UIFont().themeHNMediumFont(size: 34)
        self.addSubview(tipLabel)
        self.addSubViews([accountTextField,keyTextField,addAccountBtn])

        accountTextField.snp.makeConstraints { (make) in
            make.left.equalTo(tipLabel.snp.left)
            make.top.equalTo(tipLabel.snp.bottom).offset(20)
            make.width.equalTo(SCREEN_WIDTH - 32)
            make.height.equalTo(60)
        }

        keyTextField.snp.makeConstraints { (make) in
            make.left.equalTo(accountTextField)
            make.top.equalTo(accountTextField.snp.bottom).offset(14)
            make.width.height.equalTo(accountTextField)
        }

        addAccountBtn.snp.makeConstraints { (make) in
            make.top.equalTo(keyTextField.snp.bottom).offset(24)
            make.right.equalTo(keyTextField.snp.right)
            make.width.equalTo(104)
            make.height.equalTo(48)
        }
    }

    @objc func addAccountBtnClick(){
        if self.accountTextField.text!.isBlank {
            SVProgressHUD.showError(withStatus: "请输入账号")
        } else if self.keyTextField.text!.isBlank {
            SVProgressHUD.showError(withStatus: "请输入密钥")
        } else if self.keyTextField.text!.count != 16 && self.keyTextField.text!.count != 32 {
            SVProgressHUD.showError(withStatus: "密钥格式错误")
        } else {
            if self.addCodeButtonBlock != nil {
                /// 转为大写
                let str = self.keyTextField.text!.uppercased()
                self.addCodeButtonBlock!(self.accountTextField.text!,str)
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        accountTextField.extSetBorderWidth(2, color: .clear)
        keyTextField.extSetBorderWidth(2, color: .clear)
        if textField.tag == 300 {
            accountTextField.extSetBorderWidth(2, color: .colorWithHexString(ThemeMainColor))
        } else if textField.tag == 301 {
            keyTextField.extSetBorderWidth(2, color: .colorWithHexString(ThemeMainColor))
        }
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard let text = textField.text else {
            return true
        }
        //防止删除键无效
        if string == "" {
            return true;
        }
        if textField == keyTextField {
            //设置只能输入str后面字符串中的字符
            let str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567abcdefghijklmnopqrstuvwxyz";
            let cs:NSCharacterSet = NSCharacterSet.init(charactersIn: str);
            let str1 = string.components(separatedBy: cs as CharacterSet);
            let str2 = str1.joined(separator: "");
            let result = str2 == string;
//            print(result);
//            if result == true {
////            postValueBlock!();
//            }
            //设置输入的长度不超过10
            let textLength = text.count + string.count - range.length

            return textLength<=32 && !result;
        }
        return true
    }

}
