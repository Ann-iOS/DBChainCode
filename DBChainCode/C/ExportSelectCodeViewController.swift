//
//  ExportSelectCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/15.
//

import UIKit
import SVProgressHUD

class ExportSelectCodeViewController: UIViewController {

    var rightItemButton = UIButton.init()
    lazy var tableView : UITableView = {
        let view = UITableView.init(frame: self.view.frame, style: .plain)
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: kTabBarHeight + kNavBarHeight + 60, right: 0)
        view.register(ExportSelectCodeTableViewCell.classForCoder(), forCellReuseIdentifier: ExportSelectCodeTableViewCell.identifierCellID)
        return view
    }()

    lazy var exportBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle(" 导出", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setImage(UIImage(named: "export_code_select"), for: .normal)
        btn.setImage(UIImage(named: "export_code_select"), for: .highlighted)
        btn.backgroundColor = .colorWithHexString(ThemeMainColor)
        btn.extSetCornerRadius(8)
        btn.addTarget(self, action: #selector(exportButtonClick), for: .touchUpInside)
        return btn
    }()

    var modelArr :[ExportCodeModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    var codeListArr :[[String:Any]] = [] {
        didSet {
            modelArr.removeAll()
            for dic in codeListArr {
                let model = ExportCodeModel()
                model.accountStr = dic["name"] as? String
                model.keyStr = dic["keyStr"] as? String
                model.index = dic["index"] as? String
                model.code = dic["code"] as? String
                model.isSelect = false
                modelArr.append(model)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "已选择0个"
        self.selectModelArr.removeAll()
        rightItemButton.isSelected = false
        if FileTools.sharedInstance.isFileExisted(path: codePath) {
            /// 已经存在
            let dpathArr = NSArray(contentsOfFile: codePath)
            self.codeListArr = dpathArr as! [[String:Any]]
        } else {
            /// 没有数据
            print("没有数据!!!!")
        }
    }

    var selectModelArr :[ExportCodeModel] = []{
        didSet {
            self.title = "已选择\(selectModelArr.count)个"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        rightItemButton.setTitle("全选", for: .normal)
        rightItemButton.setTitle("取消", for:.selected )
        rightItemButton.setTitleColor(.black, for: .normal)
        rightItemButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        rightItemButton.addTarget(self, action: #selector(selectAllCodeClick), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightItemButton)

        view.addSubview(tableView)
        view.addSubview(exportBtn)
        exportBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-55)
            make.width.equalTo(100)
            make.height.equalTo(54)
        }
    }

    @objc func selectAllCodeClick() {

        if self.modelArr.count > 0 {
            selectModelArr.removeAll()
            let tempModelArr = self.modelArr
            if rightItemButton.isSelected == false {
                rightItemButton.isSelected = true
                self.modelArr.removeAll()
                for model in tempModelArr {
                    model.isSelect = true
                    modelArr.append(model)
                    selectModelArr.append(model)
                }
            } else {
                rightItemButton.isSelected = false
                self.modelArr.removeAll()
                for model in tempModelArr {
                    model.isSelect = false
                    modelArr.append(model)
                }
            }
        }
    }

    @objc func exportButtonClick(){
        if self.selectModelArr.count > 0 {
            var qrcodeArr :[String] = []
            self.selectModelArr.forEach { (model) in
                let dic = ["code":model.code,"key":model.keyStr,"title":model.accountStr]
                let dicStr = dic.toJsonString()
                qrcodeArr.append(dicStr!)
            }

            let vc = ExportQRCodeViewController()
            let codeStr = qrcodeArr.joined(separator: ",")
            vc.qrCodeStr = "[\(codeStr)]"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ExportSelectCodeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ExportSelectCodeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ExportSelectCodeTableViewCell.identifierCellID, for: indexPath) as? ExportSelectCodeTableViewCell

        if cell == nil {
            cell = ExportSelectCodeTableViewCell.init(style: .default, reuseIdentifier: ExportSelectCodeTableViewCell.identifierCellID)
        }
        cell!.selectionStyle = .none
        cell?.model = self.modelArr[indexPath.row]
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArr[indexPath.row]
        model.isSelect.toggle()
        if model.isSelect == true {
            if !self.selectModelArr.contains(model) {
                self.selectModelArr.append(model)
            }
        } else {
            self.selectModelArr = self.selectModelArr.filter({$0 != model})
        }
        self.modelArr[indexPath.row] = model

        if self.selectModelArr.count == self.modelArr.count {
            self.rightItemButton.isSelected = true
        } else {
            self.rightItemButton.isSelected = false
        }
    }

}

class ExportSelectCodeTableViewCell: UITableViewCell {

    static let identifierCellID = "SELECTCODECELLID"

    var model = ExportCodeModel() {
        didSet{
            txtLabel.text = model.accountStr
            selectBtn.isSelected = model.isSelect
        }
    }

    lazy var selectBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "export_code_nor"), for: .normal)
        btn.setImage(UIImage(named: "export_code_sel"), for: .selected)
        return btn
    }()

    lazy var txtLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubViews([selectBtn,txtLabel])
        selectBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.width.height.equalTo(24)
        }
        txtLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(selectBtn.snp.right).offset(16)
            make.right.equalToSuperview().offset(-10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
