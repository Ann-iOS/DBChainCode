//
//  SettingCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/14.
//

import UIKit

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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
