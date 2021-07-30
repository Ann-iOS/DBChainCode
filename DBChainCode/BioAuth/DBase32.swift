//
//  DBase32.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/16.
//

import Foundation

let kBase32Charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
let kBase32Synonyms = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz"
let kBase32Sep = " -"


struct DBase32 {
    
    func addOTPWithTimerLag(keyStr:String) -> Data {
        let coder :GTMStringEncoding = GTMStringEncoding.stringEncoding(with: kBase32Charset) as! GTMStringEncoding
        coder.addDecodeSynonyms(kBase32Synonyms)
        coder.ignoreCharacters(kBase32Sep)
        let data = coder.decode(keyStr)
        if data != nil {
            return data!
        }
        return Data.init()
    }
}
