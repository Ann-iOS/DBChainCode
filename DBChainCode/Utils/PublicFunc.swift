//
//  PublicFunc.swift
//  DBChain
//
//  Created by iOS on 2020/10/29.
//

import Foundation

// JSON(对象)转Data
func JSONObjectToData(json: Any) -> Data? {
    do {
        return try JSONSerialization.data(withJSONObject: json, options: []);
    } catch {
    }
    return nil;
}
 
// 字典|数组 转JSON字符串
func ObjectToJSONString(object: Any) -> String? {
    do {
        let data = try JSONSerialization.data(withJSONObject: object, options: []);
        let JSONString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
        return JSONString;
    } catch {
    }
    return nil;
}
 
// 字典|数组 转Data
func ObjectToData(object: Any) -> Data? {

    do {
        return try JSONSerialization.data(withJSONObject: object, options: []);
    } catch {
    }
    return nil;
}



