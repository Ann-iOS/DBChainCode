//
//  TJAuthErrors.swift
//  BioAuth
//
//  Created by Tejas Ardeshna on 03/11/17.
//  Copyright © 2017 Tejas Ardeshna.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import LocalAuthentication

// Authentication Errors
public enum TJAuthErrors {
    
    case appCancel, failed, userCancel, userFallback, systemCancel, passcodeNotSet, biometryNotEnrolled, biometryLockedout, invalidContext , biometryNotAvailable,other
    
    public static func errorType(_ error: LAError) -> TJAuthErrors {
        switch Int32(error.errorCode) {
            
        case kLAErrorAuthenticationFailed:
            return failed
        case kLAErrorUserCancel:
            return userCancel
        case kLAErrorUserFallback:
            return userFallback
        case kLAErrorSystemCancel:
            return systemCancel
        case kLAErrorPasscodeNotSet:
            return passcodeNotSet
        case kLAErrorBiometryNotEnrolled:
            return biometryNotEnrolled
        case kLAErrorBiometryLockout:
            return biometryLockedout
        case kLAErrorAppCancel:
            return appCancel
        case kLAErrorInvalidContext:
            return invalidContext
        case kLAErrorBiometryNotAvailable:
            return biometryNotAvailable
        default:
           return other
        }
    }
    
    // get error message based on type
    public func getMessage() -> String {
        switch self {
        case .appCancel:
            return "应用程序已取消身份验证"
        case .failed:
            // 用户未能提供有效凭据
            return "验证失败 请重试"
        case .invalidContext:
            return "上下文无效"
        case .userFallback:
            return "用户选择使用回退"
        case .userCancel:
            return "请重新操作"
        case .passcodeNotSet:
            return "设备上未设置密码"
        case .systemCancel:
            return "认证被系统取消"
        case .biometryNotEnrolled:
            return "生物识别未在设备上注册"
        case .biometryLockedout:
            return "尝试失败次数过多"
        case .biometryNotAvailable:
            return "生物识别在设备上不可用"
        case .other:
            return "未找到错误代码。"
        }
    }
}


