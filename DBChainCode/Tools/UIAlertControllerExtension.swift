//
//  AlertAction.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/17.
//

import Foundation
import UIKit

let CancelTitle     =   "Cancel"
let OKTitle         =   "OK"
typealias AlertViewController = UIAlertController

struct AlertAction {

    var title: String = ""
    var type: UIAlertAction.Style? = .default
    var enable: Bool? = true
    var selected: Bool? = false

    init(title: String, type: UIAlertAction.Style? = .default, enable: Bool? = true, selected: Bool? = false) {
        self.title = title
        self.type = type
        self.enable = enable
        self.selected = selected
    }
}

extension UIViewController {

    // Show Alert or Action sheet
    func getAlertViewController(type: UIAlertController.Style, with title: String?, message: String?, actions:[AlertAction], showCancel: Bool , actionHandler:@escaping ((_ title: String) -> ())) -> AlertViewController {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: type)

        // items
        var actionItems: [UIAlertAction] = []

        // add actions
        for (index, action) in actions.enumerated() {

            let actionButton = UIAlertAction(title: action.title, style: action.type!, handler: { (actionButton) in
                actionHandler(actionButton.title ?? "")
            })

            actionButton.isEnabled = action.enable!
            if type == .actionSheet { actionButton.setValue(action.selected, forKey: "checked") }
            actionButton.setAssociated(object: index)

            actionItems.append(actionButton)
            alertController.addAction(actionButton)
        }

        // add cancel button
        if showCancel {
            let cancelAction = UIAlertAction(title: CancelTitle, style: .cancel, handler: { (action) in
                actionHandler(action.title!)
            })
            alertController.addAction(cancelAction)
        }
        return alertController
    }
}

extension UIAlertController {
}
