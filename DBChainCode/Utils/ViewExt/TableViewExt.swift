//
//  TableViewExt.swift
//  Chainup
//
//  Created by zewu wang on 2018/8/7.
//  Copyright © 2018年 zewu wang. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    func adjustBehaviorDisable() {
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        }else {
            
        }
    }
}

extension UITableView{
    
    func extSetTableView(_ delegate : Any ,_ dataSource : Any ,_ backgroundColor : UIColor = .colorWithHexString(ThemeVcBackground_Color) , _ sepStyle : UITableViewCell.SeparatorStyle = .none){
        self.delegate = delegate as? UITableViewDelegate
        self.dataSource = dataSource as? UITableViewDataSource
        self.backgroundColor = backgroundColor
        self.separatorStyle = sepStyle
    }
    
    func extRegistCell(_ cells : [AnyClass] , _ identifiers : [String]){
        for i in 0..<cells.count{
            self.register(cells[i], forCellReuseIdentifier: identifiers[i])
        }
    }
    
}

extension UITableViewCell{
    func extSetCell(_ backgroundColor : UIColor = .colorWithHexString(ThemeBlockColor) , selStyle : UITableViewCell.SelectionStyle = .none){
        self.contentView.backgroundColor = backgroundColor
        self.selectionStyle = selStyle
    }
}
