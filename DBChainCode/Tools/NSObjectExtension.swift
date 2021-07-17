//
//  NSObjectExtension.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/17.
//

import Foundation
import Foundation
import ObjectiveC.NSObjCRuntime

/// NSObject associated object
public extension NSObject {

    /// keys
    private struct AssociatedKeys {
        static var descriptiveName = "associatedObject"
    }

    /// set associated object
    @objc func setAssociated(object: Any) {
        objc_setAssociatedObject(self, &AssociatedKeys.descriptiveName, object, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /// get associated object
    @objc func associatedObject() -> Any? {
        return objc_getAssociatedObject(self, &AssociatedKeys.descriptiveName)
    }
}
