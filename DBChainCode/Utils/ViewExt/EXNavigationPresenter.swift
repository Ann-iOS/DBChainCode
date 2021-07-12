//
//  EXNavigationPresenter.swift
//  Chainup
//
//  Created by liuxuan on 2019/11/22.
//  Copyright © 2019 zewu wang. All rights reserved.
//

import UIKit

public protocol EXNavigationPresenter {
//    associatedtype StoryboardIdentifier: RawRepresentable
    func presentF(_ controller:UIViewController,animated:Bool,completion: (() -> Void)?)

}

public extension EXNavigationPresenter where Self:UIViewController {
    func presentF(_ controller:UIViewController,animated:Bool,completion: (() -> Void)?) {
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true) {
            completion?()
        }
    }
}
