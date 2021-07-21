//
//  SettingCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit
import SVProgressHUD

/// 保存 code plist 路径
let codePath = FileTools.sharedInstance.docDir() + "/codes.plist"

class SettingCodeViewController: UIViewController {

    lazy var contenView : SettingCodeView = {
        let view = SettingCodeView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "输入账号详情"
        contenView.frame = self.view.frame
        view.addSubview(contenView)

        contenView.addCodeButtonBlock = { (accountStr: String,keyStr:String) in
            let data = DBase32().addOTPWithTimerLag(keyStr: keyStr)
            let generator = TOTPGenerator.init(secret: data, algorithm: kOTPGeneratorSHA1Algorithm, digits: 6,period: 30)
            let code = generator?.generateOTP()
            if code != nil {
                /// 保存本地
                var dicArr :[[String:Any]] = []
                
                let dic :Dictionary<String,Any> = ["name":accountStr,
                                                   "keyStr":keyStr,
                                                   "code":code!]

                if FileTools.sharedInstance.isFileExisted(path: codePath) == true {
                    /// 已经存在  更新数据
                    var pathArr = NSArray(contentsOfFile: codePath) as! [[String:Any]]
                    var keyStrArr :[String] = []

                    for pdic in pathArr {
                        keyStrArr.append(pdic["keyStr"] as! String)
                    }
                    /// 过滤重复
                    if keyStrArr.contains(keyStr) {
                        SVProgressHUD.showError(withStatus: "当前密钥已存在, 不可重复添加")
                    } else {
                        pathArr.append(dic)
                        dicArr = pathArr
                        NSArray(array: dicArr).write(toFile: codePath, atomically: true)
                        SVProgressHUD.showSuccess(withStatus: "添加成功")
                    }
                    
                } else {
                    /// 文件不存在. 直接添加
                    dicArr.append(dic)
                    NSArray(array: dicArr).write(toFile: codePath, atomically: true)
                    SVProgressHUD.showSuccess(withStatus: "添加成功")
                }

                self.navigationController?.popViewController(animated: true)

            } else {
                SVProgressHUD.showError(withStatus: "请输入正确的密钥")
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
