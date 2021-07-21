//
//  BaseViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/21.
//

import UIKit
import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super .viewDidLoad()
        self.view.backgroundColor = .white
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        setNavBar()
        setupUI()
    }

    public func setupUI() {

    }

    public func setNavBar(){

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

func DBPrint<N>(message: N, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line){
    #if DEBUG
    print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息:\(message)")
    #endif
}
