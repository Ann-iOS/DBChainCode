//
//  ArrayExtension.swift
//  DBChain
//
//  Created by iOS on 2020/11/7.
//

import Foundation

extension Array {
    
    // 去重
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
    
//    随机打乱一个数组
    /**
         let sortArr:[String] = ["1","2","3","4","5"]
         let tempArr = self.shuffleArray(arr: sortArr)
         DBPrint(message:"FlyElephant-随机数组:\(tempArr)")
     */
    func shuffleArray(arr:[String]) -> [String] {
        
        var data:[String] = arr
        
        guard arr.count > 1 else {
            return data
        }
        
        for i in 1..<arr.count {
            let index:Int = Int(arc4random()) % i
            if index != i {
                data.swapAt(i, index)
            }
        }
        return data
    }



}
