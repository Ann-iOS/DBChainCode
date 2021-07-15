//
//  SettingCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit

class SettingCodeViewController: UIViewController {

    let kBase32Charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
    let kBase32Synonyms = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz"
    let kBase32Sep = " -"
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
            let data = self.addOTPWithTimerLag(keyStr: keyStr)
            let generator = TOTPGenerator.init(secret: data, algorithm: kOTPGeneratorSHA1Algorithm, digits: 6,period: 30)
            let code = generator?.generateOTP()
            NSLog("\(code!)")
        }
    }
    

    func addOTPWithTimerLag(keyStr:String) -> Data {
        let coder :GTMStringEncoding = GTMStringEncoding.stringEncoding(with: kBase32Charset) as! GTMStringEncoding
        coder.addDecodeSynonyms(kBase32Synonyms)
        coder.ignoreCharacters(kBase32Sep)
        return coder.decode(keyStr)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
