//
//  ModifyListTableViewCell.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/15.
//

import UIKit

class ModifyListTableViewCell: UITableViewCell {
    @IBOutlet weak var txtLabel: UILabel!

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


    }

    @IBAction func moveCodeBtn(_ sender: Any) {

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
