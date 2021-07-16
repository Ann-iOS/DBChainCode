//
//  ModifyListTableViewCell.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/15.
//

import UIKit

typealias ModifyEditCodeNameBlock = (_ cell:ModifyListTableViewCell) -> ()
typealias ModifyMoveListIndexBlock = (_ cell:ModifyListTableViewCell) -> ()

class ModifyListTableViewCell: UITableViewCell {
    @IBOutlet weak var txtLabel: UILabel!

    var ModifyEditCodeNameBlock :ModifyEditCodeNameBlock?
    var ModifyMoveListIndexBlock :ModifyMoveListIndexBlock?

    static let ModifyCellID = "ModifyListTableViewCellID"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .colorWithHexString("F7F7F7")
        self.contentView.extSetCornerRadius(10)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }


    @IBAction func editCodeBtn(_ sender: UIButton) {
        if self.ModifyEditCodeNameBlock != nil {
            self.ModifyEditCodeNameBlock!(self)
        }
    }

    @IBAction func moveCodeBtn(_ sender: Any) {

        if self.ModifyMoveListIndexBlock != nil {
            self.ModifyMoveListIndexBlock!(self)
        }
    }


    override var frame: CGRect {
            get {
                return super.frame
            }
            set {
                var frame = newValue
                frame.origin.x += 15
                frame.size.width -= 2 * 15
                frame.origin.y += 10
                frame.size.height -= 2 * 10
                super.frame = frame
            }
        }
}
