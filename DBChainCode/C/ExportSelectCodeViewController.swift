//
//  ExportSelectCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/15.
//

import UIKit

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
        return btn
    }()

    var modelArr :[ExportCodeModel] = [] {
        didSet{
            
        }
    }

    var codeListArr :[[String:Any]] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if FileTools.sharedInstance.isFileExisted(path: codePath) {
            /// 已经存在
            print("++++++++++++++++++++++++++++++")
            let dpathArr = NSArray(contentsOfFile: codePath)
            self.codeListArr = dpathArr as! [[String:Any]]
            print("ExportSelectCodeViewController 数组: \(dpathArr!)")
        } else {
            /// 没有数据
            print("没有数据!!!!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "已选择0个"
        self.view.backgroundColor = .white
        rightItemButton.setTitle("全选", for: .normal)
        rightItemButton.setTitleColor(.black, for: .normal)
        rightItemButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightItemButton)

        view.addSubview(tableView)
        view.addSubview(exportBtn)
        exportBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-55)
            make.width.equalTo(160)
            make.height.equalTo(54)
        }
    }

}

extension ExportSelectCodeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.codeListArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ExportSelectCodeTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ExportSelectCodeTableViewCell.identifierCellID, for: indexPath) as? ExportSelectCodeTableViewCell

        if cell == nil {
            cell = ExportSelectCodeTableViewCell.init(style: .default, reuseIdentifier: ExportSelectCodeTableViewCell.identifierCellID)
        }
        cell!.selectionStyle = .none
        cell?.txtLabel.text = self.codeListArr[indexPath.row]["name"] as? String
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

class ExportSelectCodeTableViewCell: UITableViewCell {

    static let identifierCellID = "SELECTCODECELLID"
    lazy var selectBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "export_code_nor"), for: .normal)
        btn.setImage(UIImage(named: "export_code_sel"), for: .selected)
        return btn
    }()

    lazy var txtLabel : UILabel = {
        let label = UILabel()
//        label.text = "我这一次终究还是来的太迟"
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
