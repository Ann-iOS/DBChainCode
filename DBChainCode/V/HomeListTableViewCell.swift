//
//  HomeListTableViewCell.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/13.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    static let identifier = "HomeListTableViewCellID"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var copyBtn: UIButton!

//    var model = HomeCodeListModel(){
//        didSet{
//            titleLabel.text = model.accountStr
//            codeLabel.text = model.keyStr
//        }
//    }
//
    override func awakeFromNib() {
        super.awakeFromNib()

        self.contentView.backgroundColor = .colorWithHexString("F7F7F7")
        self.backgroundColor = .clear
        self.contentView.extSetCornerRadius(10)

        self.codeLabel.font = UIFont.init(name: "Roboto-BoldItalic", size: 40)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override var frame: CGRect {
            get {
                return super.frame
            }
            set {
                var frame = newValue
                frame.origin.x += 15
                frame.size.width -= 2 * 15
                frame.origin.y += 6
                frame.size.height -= 2 * 6
                super.frame = frame
            }
        }
}
