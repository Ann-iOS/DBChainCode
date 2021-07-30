# DBChainCode
## 实例
![image](https://github.com/Ann-iOS/DBChainCode/blob/main/readme.gif )
***
# 特征
* 使用Swift5.0编写 
* 自定义刷新验证码时间. 默认是30s
* 自定义密钥格式. 默认密钥为16位或者32位限定字符
* 限定字符默认为"AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz"
* 使用Base32模式转换密钥格式

# 用法
***
```
下载zip包解压. 将 BioAuth 与 OTP 文件夹拖入项目中
OTP文件夹内的文件是OC编写. 需要在桥接的头文件中导入
#import "GTMDefines.h"
#import "GTMStringEncoding.h"
#import "TOTPGenerator.h"

let data = DBase32().addOTPWithTimerLag(keyStr: keyStr)
let generator = TOTPGenerator.init(secret: data, algorithm: kOTPGeneratorSHA1Algorithm, digits: 6,period: 30)
let code = generator?.generateOTP()
```
* digits: 需要生成的验证码位数. 
* period: 刷新验证码的时间间隔

# 要求
* Xcode12
* Swift 5.0
* iOS 9.0 或更高版本

# 参考链接地址
* 简书: (https://www.jianshu.com/p/4517d3a8dfcd?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation)
* github Object-C 版本链接: (https://github.com/yazid/iOS-TOTP) 

