//
//  ModifyCodeNameViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/16.
//

import UIKit
import SVProgressHUD

class ModifyCodeNameViewController: UIViewController {

//    var currentName :String = ""{
//        didSet{
//            cNameLabel.text = currentName
//        }
//    }

    var dic :[String :Any] = [:] {
        didSet{
            cNameLabel.text = dic["name"] as? String
        }
    }

    lazy var tipLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "当前账号名"
        return label
    }()

    lazy var cNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont().themeHNMediumFont(size: 34)
        label.numberOfLines = 0
        return label
    }()

    lazy var backView : UIView = {
        let view = UIView()
        view.extSetCornerRadius(8)
        view.backgroundColor = .colorWithHexString("#F7F7F7")
        return view
    }()

    lazy var newNameTF : UITextField = {
        let tf = UITextField()
        tf.placeholder = "输入新命名"
        tf.textColor = .black
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.borderStyle = .none
        tf.backgroundColor = .clear
        return tf
    }()

    lazy var saveBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .colorWithHexString(ThemeMainColor)
        btn.setTitle("保存", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.extSetCornerRadius(8)
        btn.addTarget(self, action: #selector(saveCurrentCodeComplete), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "修改账号"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "modify_delete_code"), style: .plain, target: self, action: #selector(modifyDeleteCurrentCodeComplete))

        view.addSubViews([tipLabel,cNameLabel,backView,newNameTF,saveBtn])

        tipLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        cNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tipLabel)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(tipLabel.snp.bottom).offset(4)
        }
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(tipLabel)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(cNameLabel.snp.bottom).offset(18)
            make.height.equalTo(60)
        }
        newNameTF.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-36)
            make.center.equalTo(backView)
        }

        saveBtn.snp.makeConstraints { (make) in
            make.left.equalTo(tipLabel)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-52)
            make.height.equalTo(54)
        }
    }

    /// 删除当前账号
    @objc func modifyDeleteCurrentCodeComplete(){
        let vc = DeleteCodeHUDViewController()
        vc.type = .Alone
        vc.deleteCodeName = dic["name"] as! String
        vc.modalPresentationStyle = .overFullScreen
        vc.deleteSuccessBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        self.present(vc, animated: false, completion: nil)
    }

    /// 保存当前账号.
    @objc func saveCurrentCodeComplete() {
        if !self.newNameTF.text!.isBlank {
            if FileTools.sharedInstance.isFileExisted(path: codePath) {
                /// 已经存在
                let dpathArr = NSArray(contentsOfFile: codePath)
                let tempArr = dpathArr as! [[String:Any]]
                var newArr :[[String:Any]] = []

                for (idx,tempdic) in tempArr.enumerated() {
                    var newDic :[String:Any] = tempdic
                    if tempdic["name"] as! String == dic["name"] as! String {
                        newDic["name"] = self.newNameTF.text!
                    }
                    newArr.append(newDic)
                    if idx == tempArr.count - 1{
                        NSArray(array: newArr).write(toFile: codePath, atomically: true)
                        SVProgressHUD.showSuccess(withStatus: "修改成功")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            SVProgressHUD.showError(withStatus: "请输入新命名")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
