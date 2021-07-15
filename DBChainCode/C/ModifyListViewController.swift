//
//  ModifyListViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/15.
//

import UIKit

class ModifyListViewController: UIViewController {


    lazy var tableView : UITableView = {
        let view = UITableView.init(frame: self.view.frame, style: .plain)
        view.separatorStyle = .none
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .white
        view.rowHeight = 100
        view.register(UINib.init(nibName: "ModifyListTableViewCell", bundle: nil), forCellReuseIdentifier: ModifyListTableViewCell.ModifyCellID)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kNavAndTabHeight, right: 0)
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改列表"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "motify_list_success"), style: .plain, target: self, action: #selector(modifyListComplete))
        view.addSubview(tableView)
    }

    @objc func modifyListComplete(){
        self.dismiss(animated: true, completion: nil)
    }

}


extension ModifyListViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ModifyListTableViewCell? = tableView.dequeueReusableCell(withIdentifier: ModifyListTableViewCell.ModifyCellID, for: indexPath) as? ModifyListTableViewCell
        cell!.selectionStyle = .none
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60))
        view.backgroundColor = .white
        let txtLabel = UILabel.init(frame: CGRect(x: 24, y: 0, width: SCREEN_WIDTH, height: 60))
        txtLabel.text = "账号列表"
        txtLabel.textColor = .black
        txtLabel.font = UIFont().themeHNMediumFont(size: 20)
        view.addSubview(txtLabel)
        return view
    }
}

