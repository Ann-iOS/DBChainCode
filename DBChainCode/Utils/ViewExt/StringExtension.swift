//
//  StringExtension.swift
//  DBChain
//
//  Created by iOS on 2020/11/2.
//

import Foundation
import UIKit
// MARK: 字符串转字典
extension String {
    
    func encodBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    func decodeBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    func getCurrentLanguages() -> String {
        let languagesArr = NSLocale.preferredLanguages
        let currentLanguages = languagesArr[0]
        return currentLanguages
    }

    func toDictionary() -> [String : Any] {
        var result = [String : Any]()
        guard !self.isEmpty else { return result }
        
        guard let dataSelf = self.data(using: .utf8) else {
            return result
        }
        
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf,
                                                       options: .mutableContainers) as? [String : Any] {
            result = dic
        }
        return result
    }
    
    //  字符串是否为空
    var isBlank: Bool {
         let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
         return trimmedStr.isEmpty
     }

    /// 是否为json字符串
    func isjsonStyle(txt:String) -> Bool {
       let jsondata = txt.data(using: .utf8)
       do {
           try JSONSerialization.jsonObject(with: jsondata!, options: .mutableContainers)
           return true
       } catch {
           return false
       }
   }

    //返回传入字符串的数  英文算0.5个 例a为0.5 ab为1 汉字算1个 字符同理
    public func convert(toInt:String) -> Int {
        var number = 0
        for character in toInt {
            let characterString = String(character)
            let characterBytes = characterString.cString(using: .utf8)
            if characterBytes?.count == 2 {
                number += 1
            }else if characterBytes?.count == 4 {
                number += 2
            }
        }
        return (number+1)/2
    }
    
    //判断字符高度，需传入字符大小和宽度
    //返回的是宽度和高度
    public  func textSizeWithFont(_ font: UIFont, width:CGFloat,option : NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin) -> CGSize {
        
        var textSize:CGSize!
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        if size.equalTo(CGSize.zero) {
            
            let attributes = [NSAttributedString.Key.font:font]
            
            textSize = self.size(withAttributes: attributes)
            
        } else {
            
            let attributes = [NSAttributedString.Key.font:font]
            
            let stringRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
            
            textSize = stringRect.size
        }
        return textSize
    }
    
    public func textHeightSizeWithFont(_ font: UIFont, height:CGFloat,option : NSStringDrawingOptions = NSStringDrawingOptions.usesLineFragmentOrigin) -> CGSize {
        
        var textSize:CGSize!
        
        let size = CGSize(width: 10000, height: height)
        
        if size.equalTo(CGSize.zero) {
            
            let attributes = [NSAttributedString.Key.font:font]
            
            textSize = self.size(withAttributes: attributes)
            
        } else {
            
            let attributes = [NSAttributedString.Key.font:font]
            
            let stringRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
            
            textSize = stringRect.size
        }
        return textSize
    }



    /**
     string字符串截取
    */
    public  func extStringSub(_ range : NSRange)->String{
    
        let beforeStr = NSString.init(string: self)
        
        let afterStr = beforeStr.substring(with: range)

        return afterStr as String
    }

    /**
        获取下标
     */
    subscript (i: Int) -> Character {
      return self[index(startIndex, offsetBy: i)]
    }
    
    /**
     正则查找 形如name=value value部分
     
     - returns: value
     */
    public func regexStringUrlValueOfParam(paramName p :String) -> String {
        let reg = "(?<="+p+"\\=)[^&]+"
    
        let decodeStrUrl = self.removingPercentEncoding!
        let range =  decodeStrUrl.range(of: reg, options: String.CompareOptions.regularExpression, range: nil, locale: nil)
        if range  != nil {
            return String(decodeStrUrl[range!])
        }
        return ""
    }
    /**
     判断字符串是否为纯数字
     
     - returns: value
     */
    public func isNumber() -> Bool{
        if self.count == 0{
            return false
        }else{
            let reg = "[0-9]*"
            let predicate = NSPredicate.init(format: "SELF MATCHES %@", reg)
            let result = predicate.evaluate(with: self)
            return result
        }
    }
    
    /// 字符串截取(可数的闭区间)例子：
    /// let str = "hello word"
    /// let tmpStr = hp[0 ... 5] tmpStr = hello
    /// - Parameter r: 字符串范围
    public subscript (r: CountableClosedRange<Int>) -> String{
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            var endIndex:String.Index?
            if r.upperBound > self.count{
                endIndex = self.index(self.startIndex, offsetBy: self.count)
            }else{
                endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            }
            return String(self[startIndex..<endIndex!])
        }
    }
    
    /// 字符串截取(可数的开区间)例子：
    /// let str = "hello word"
    /// let tmpStr = hp[0 ..< 5] tmpStr = hello
    /// - Parameter r: 字符串范围
    public subscript (r: CountableRange<Int>) -> String{
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            var endIndex:String.Index?
            if r.upperBound > self.count{
                endIndex = self.index(self.startIndex, offsetBy: self.count)
            }else{
                endIndex = self.index(self.startIndex, offsetBy: r.upperBound-1)
            }
            return String(self[startIndex..<endIndex!])
        }
    }
    
    /// 字符串替换(可数的闭区间)
    /// 用法str.sd_replaceSubrange(r: 0..<5, with: "hahahah")
    /// - Parameters:
    ///   - r: range(可数的闭区间)
    ///   - with: 备用替换的String
    public mutating func sd_replaceSubrange(r: CountableClosedRange<Int>,with:String){
        let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        var endIndex:String.Index?
        if r.upperBound > self.count{
            endIndex = self.index(self.startIndex, offsetBy: self.count)
        }else{
            endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        }
//        self.replaceSubrange(Range<String.Index>(startIndex..<endIndex!), with: with)
    }
    
    /// 去除空格
    func removeAllSpace(str:String) -> String{
        return str.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }


    /// 编码
    func base64Encoding(plainData:Data) -> String {
//        let plainData = plainString.data(using: String.Encoding.utf8)
        let base64String = plainData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String
      }
    
    /// 解码
    func base64Decoding(encodedString:String) -> Data {

        let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        guard decodedData != nil else {
            return Data(base64Encoded: encodedString)!
        }
//        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedData! as Data
    }


    //数组(Array)转换为JSON字符串
   public func getJSONStringFromArray(_ array:NSArray) -> String {
        if (!JSONSerialization.isValidJSONObject(array)) {
            return String()
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }

    /// JSONString转换为数组
    func getArrayFromJSONString(jsonString:String) -> NSArray{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray
    }

    //字符串转时间戳
        func timeStrChangeTotimeInterval(timeStr: String?, dateFormat:String?) -> String {
            if timeStr?.count ?? 0 > 0 {
                return ""
            }
            let format = DateFormatter.init()
            format.dateStyle = .medium
            format.timeStyle = .short
            if dateFormat == nil {
                format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            }else{
                format.dateFormat = dateFormat
            }
            let date = format.date(from: timeStr!)
            return String(date!.timeIntervalSince1970)
        }


    //时间戳转成字符串   13 位 毫秒级
      func timeIntervalChangeToTimeStr(timeInterval:TimeInterval, dateFormat:String?) -> String {
          let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval/1000)
          let formatter = DateFormatter.init()
          if dateFormat == nil {
              formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
          }else{
              formatter.dateFormat = dateFormat
          }
          return formatter.string(from: date as Date)
      }

    //MARK: -时间戳转时间函数
    func timeStampToString(timeStamp: Double, outputFormatter: String)->String {
       //时间戳为毫秒级要／1000 (13位数)， 秒就不用除1000（10位数），参数带没带000
        let timeString = String.init(format: "%d", timeStamp)

        let timeSta:TimeInterval

        if timeString.count == 10 {
            timeSta = TimeInterval(timeStamp)
        }else{
            timeSta = TimeInterval(timeStamp / 1000)
        }

        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //设定时间格式,这里可以设置成自己需要的格式yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat = outputFormatter
        return dfmatter.string(from: date as Date)
    }

    //MARK: -时间转时间戳函数
    func timeToTimeStamp(time: String ,inputFormatter:String) -> Double {
        let dfmatter = DateFormatter()
       //设定时间格式,这里可以设置成自己需要的格式
        dfmatter.dateFormat = inputFormatter
        let last = dfmatter.date(from: time)
        let timeStamp = last?.timeIntervalSince1970
        return timeStamp!
    }
    
    // swift
    //MARK: -根据后台时间戳返回几分钟前，几小时前，几天前
    func updateTimeToCurrennTime(timeStamp: Double) -> String {
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        //时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
        //时间差
        let reduceTime : TimeInterval = currentTime - timeSta
        //时间差小于60秒
        if reduceTime < 60 {
            return "刚刚"
        }
        //时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        let days = Int(reduceTime / 3600 / 24)
        if days < 30 {
            return "\(days)天前"
        }
        //不满足上述条件---或者是未来日期-----直接返回日期
        let date = NSDate(timeIntervalSince1970: timeSta)
        let dfmatter = DateFormatter()
        //yyyy-MM-dd HH:mm:ss
        dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }

    /// UTC 转换 字符串
    func get_Date_time_from_UTC_time(string : String) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSZ"
        // "2018-09-11T09:53:25.000+0000"
        let dateFromInputString = dateFormatter.date(from: string)

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if dateFromInputString != nil {
            return dateFormatter.string(from: dateFromInputString!)
        } else {
            return "N/A"
        }

      }
    
    func GetFormatedDate(date_string:String,dateFormat:String)-> String{

       let dateFormatter = DateFormatter()
       dateFormatter.locale = Locale(identifier: "zh_CN")
       dateFormatter.dateFormat = dateFormat

       let dateFromInputString = dateFormatter.date(from: date_string)
       dateFormatter.dateFormat = "dd-MM-yyyy" // Here you can use any dateformate for output date

       if(dateFromInputString != nil){
           return dateFormatter.string(from: dateFromInputString!)
       }
       else{
           return "N/A"
       }
   }


    static func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatter.date(from: string)
            return date!
        }

    static func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
            let timeZone = TimeZone.init(identifier: "UTC")
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            formatter.locale = Locale.init(identifier: "zh_CN")
            formatter.dateFormat = dateFormat
            let date = formatter.string(from: date)
            return date.components(separatedBy: " ").first!
        }

    /// 生成二*:维**/码图片, 带中间icon
    func ext_createQRImage(_ qrImageName: String = "") -> UIImage? {
        guard !self.isEmpty else { return nil }

        let stringData = self.data(using: .utf8, allowLossyConversion: false)
        // 创建一个二@@维##码的滤镜
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
        let qrCIImage = qrFilter?.outputImage
        // 创建一个颜色滤镜,黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(qrCIImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        // 返回二@@维##码image
        var codeImage: UIImage?
        if let outImage = colorFilter?.outputImage {
            codeImage = UIImage(ciImage: outImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10)))
        }

        // 通常,二@@维##码都是定制的,中间都会放想要表达意思的图片
        if let iconImage = UIImage(named: qrImageName), let codeImg = codeImage {
            let rect = CGRect(x: 0, y: 0, width: codeImg.size.width, height: codeImg.size.height)
            UIGraphicsBeginImageContext(rect.size)

            codeImg.draw(in: rect)
            let avatarSize = CGSize(width: rect.size.width * 0.25, height: rect.size.height * 0.25)
            let x = (rect.width - avatarSize.width) * 0.5
            let y = (rect.height - avatarSize.height) * 0.5
            iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()
            return resultImage
        }
        return codeImage
    }

}

extension String {
    /// 字符串的匹配范围
    ///
    /// - Parameters:
    ///     - matchStr: 要匹配的字符串
    /// - Returns: 返回所有字符串范围
    @discardableResult
    func hw_exMatchStrRange(_ matchStr: String) -> [NSRange] {
        var selfStr = self as NSString
        var withStr = Array(repeating: "X", count: (matchStr as NSString).length).joined(separator: "") //辅助字符串
        if matchStr == withStr { withStr = withStr.lowercased() } //临时处理辅助字符串差错
        var allRange = [NSRange]()
        while selfStr.range(of: matchStr).location != NSNotFound {
            let range = selfStr.range(of: matchStr)
            allRange.append(NSRange(location: range.location,length: range.length))
            selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
        }
        return allRange
    }


    ///（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        // 如果没有找到就返回-1
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }

    
}



///  十六进制字符串 转 Uint8    8进制

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { start in
            guard start < self.endIndex else { return nil }
            let end = self.index(start, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { start = end }
            return UInt8(self[start..<end], radix: 16)
        }
    }
}
