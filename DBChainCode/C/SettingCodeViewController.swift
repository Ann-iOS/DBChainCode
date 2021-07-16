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

                var dic :Dictionary<String,Any> = ["name":accountStr,
                                                   "keyStr":keyStr,
                                                   "code":code!]

                if FileTools.sharedInstance.isFileExisted(path: codePath) == true {
                    /// 已经存在  更新数据
                    let pathArr = NSArray(contentsOfFile: codePath)

                    if pathArr?.count ?? 0 > 0  {
                        dic["index"] = "\(dicArr.count + 1)"
                        dicArr = pathArr!.adding(dic) as! [[String:Any]]
                        NSArray(array: dicArr).write(toFile: codePath, atomically: true)
                    }

                } else {
                    /// 文件不存在. 直接添加
                    dic["index"] = "\(dicArr.count + 1)"
                    dicArr.append(dic)
                    NSArray(array: dicArr).write(toFile: codePath, atomically: true)
                }

                SVProgressHUD.showSuccess(withStatus: "添加成功")
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
