//
//  ServiceClauseViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/20.
//

import UIKit

enum ClauseType {
    case service
    case privacy
}

class ServiceClauseViewController: UIViewController {

    var type = ClauseType.service
    let privacyStr = "感谢您信任并使用库链验证器客户端！\n\n库链验证器客户端（以下或称我们）非常注重保护用户个人信息及个人隐私，由于区块链技术的特性，您在使用我们的服务时，我们不会收集和使用您的任何相关信息。对此，我们依据最新的法律法规要求，制定了《库链验证器客户端用户隐私政策》（以下简称《隐私政策》），请务必仔细阅读。\n\n我们承诺将按业界成熟的技术安全标准和措施保护您的个人隐私和相关信息。如果您不同意本《隐私政策》的任何内容，您可以选择停止使用服务；当您使用或继续使用我们的服务，即意味着您已充分阅读、理解并接受本《隐私政策》的全部内容，同意我们按此不收集、不使用、不存储您的任何隐私相关信息。\n\n本《隐私政策》包括以下几个方面的问题：\n\n• 我们可能收集的信息\n• 我们可能调用的设备权限\n• 我们如何使用和保护信息\n• 未成年人使用条款\n• 修订和通知\n• 联系我们\n\n一、我们可能收集的信息\n\n1. 您向我们提供的信息\n\n您在使用我们的服务时不需要提供任何的信息。\n\n2. 我们获取的您的信息\n\n2.1 使用过程中产生的日志信息，包括浏览、点击、搜索等；\n2.2 移动设备或软件信息：包括设备号、设备IP、系统版本等；\n\n3. 从第三方获得的信息\n\n使用第三方账号验证功能服务时，收集到的第三方账号的昵称、唯一识别码等信息。\n\n二、我们可能调用的设备权限\n\n我们可能会调用您的一些设备权限，以下是我们可能调用的设备权限及对应的使用目的说明，您随时可以选择关闭下列权限的授权，但可能会影响部分或全部功能。\n\n1. 无线数据：访问获取无线局域网及蜂窝移动数据；\n2. 相机：用于提供用户上传及时拍摄照片的功能；\n3. 存储：用户下载自己加密后的文件等信息；\n\n三、我们如何使用和保护信息\n\n1. 我们如何使用信息\n\n我们不主动收集用户的信息，我们将根据合法、正当、必要的原则，收集少量致力于维护用户权益的信息，这些信息将用于：\n\n1.1 保障产品的正常运行，优化、改善各项功能和服务；\n1.2 满足用户个性化需求和互动体验；\n1.3 保障用户和服务的使用安全。\n\n2. 我们如何保护信息\n\n我们会采用多项安全区块链技术加密防护措施，包括制度规范、安全技术来防止信息的丢失、损坏，未经授权的访问、使用、披露、修改等。\n\n3. 除以下情形外，未征得您的同意，我们不会主动向第三方权利机构共享您的可识别个人信息：\n\n3.1 已取得您或您监护人的授权；\n3.2 违反国家法律规定，政府部门、司法机关依照法定程序要求；\n3.3 为避免您或他人生命、自由、身体或财产等遭遇不法侵害；\n3.4 国家法律法规规定的其它所有情形。\n\n四、我们如何共享信息\n\n除非经过您的同意，我们不会向第三方共享、转让可识别的个人信息。特定前提下，我们将要求第三方对您的个人信息采取保护措施并且严格遵守相关法律法规与监管要求。第三方如要改变个人信息的处理目的，将再次征求您的授权同意。\n\n4.1 强制性共享：我们可能会根据法律法规规定，或按照法律法规、法律程序的要求或强制性的政府要求或司法裁定等，与第三方共享您的个人信息。\n\n五、未成年人使用条款\n\n未成年人在使用服务前，应在父母或其他监护人指导下共同阅读并同意本《隐私政策》。\n\n六、修订和通知\n\n为提供更好的服务，我们可能适时修订本《隐私政策》的条款并在显著位置提示。在该种情况下，若您继续使用我们的服务，即表示同意受经修订的政策约束。\n\n七、联系我们\n\n如您对本《隐私政策》或其他相关事宜有任何疑问、意见或建议，请浏览库链官网（https://www.dbchain.cloud）或发送邮件至support@dbchain.cloud。\n本协议解释权及修订权归深圳市库链科技有限公司所有，在法律允许的范围内，我们拥有解释和修改的权利。"

    let serviceStr = "本许可条款是 深圳市库链科技有限公司（以下简称“库链”）与您之间达成的协议。请仔细阅读。本条款适用于上述软件，包括您用来接收该软件的介质（如果有）。本条款也适用于库链为该软件提供的任何\n\n• 更新\n• 补充程序\n• 基于加密的服务，和\n• 支持服务\n\n但附带有其他条款的除外；在附带有其他条款的情况下，应遵守此类其他条款。\n\n使用本软件，即表示您接受本条款。如果您不接受本条款，请不要使用该软件。\n\n如果您遵守本许可条款，将拥有以下永久权利。\n\n一、安装和使用权利\n\n安装和使用。您可以在您的设备上安装和使用一份软件拷贝。\n\n第三方程序。本软件可能包含库链（而不是第三方）根据本协议的规定许可您使用的第三方程序。所提供的第三方程序的声明（如果有）仅供参考。\n\n二、基于 INTERNET 的服务\n\n库链随该软件提供基于 Internet 的服务。此类服务可能随时更改或取消。本软件通过 Internet（包括第三方 Interne站点）连接到服务和计算机系统；使用本软件即表示您同意传输标准的设备信息（包括但不限于有关您的设备、系统和应用程序软件以及外围设备的技术信息）以使用基于 Interne的服务或无线服务。如果提供了与使用本软件访问您所使用服务相关的其他条款，则应遵守本条款。您不得以任何可能损害这些服务或妨碍他人使用这些服务的方式使用这些服务。您不得利用这些服务尝试以任何手段擅自访问任何服务、数据、帐户或网络。\n\n三、许可范围\n\n软件只授予使用许可，而非出售。本协议只授予您使用该软件的某些权利。库链保留所有其他权利。除非适用的法律赋予您此项限制之外的权利，否则您只能在本协议明示允许的范围内使用该软件。为此，您必须遵守该软件中的任何技术限制，这些限制只允许您以特定的方式使用该软件不得\n\n• 绕过该软件中的任何技术限制；\n• 对本软件进行反向工程、反向编译或反汇编；尽管有此项限制，但如果适用的法律明示允许上述活动，则不适用此项限制；\n• 制作超过本协议所规定或适用的法律所允许数量（尽管有此项限制）的软件副本；\n• 发布该软件供他人复制；\n• 出租、租赁或出借该软件；\n• 将该软件或本协议转让给任何第三方；\n• 或使用该软件提供商业软件托管服务。\n\n四、备份副本\n\n您可以制作该软件的一个备份副本。该副本只能用于重新安装该软件。\n\n五、文档\n\n所有能够合法访问您的计算机或内部网络的用户都可以复制该文档，但仅供内部参考之用。\n\n六、出口限制\n\n该软件受中国出口法律和法规的约束。您必须遵守适用于该软件的所有国内和国际出口法律和法规。这些法律包括对目的地、最终用户和最终用途的各种限制。\n\n七、支持服务\n\n由于该软件按“现状”提供，我们可能不会为其提供支持服务。\n\n八、完整协议\n\n本协议以及您使用的补充程序、更新、基于 Internet 的服务和支持服务的有关条款，共同构成了该软件和支持服务的完整协议。\n\n九、适用的法律\n\n中国。如果您在中国购买该软件，则对本协议的解释以及由于违反本协议而引起的索赔均以中国法律为准并受其管辖，而不考虑法律冲突原则。您所居住的法律适用于其他所有索赔项目，包括根据消费者保护法、不正当竞争法及侵权行为提出的相关索赔。\n\n除中国之外的其他国家/地区。如果您在其他任何国家/地区购买该软件，则应遵守该国家/地区的法律。\n\n十、法律效力\n\n本协议阐述了某些法定权利。根据您所在国家/地区的法律规定，您可能享有其他权利。您还可能享有与您的软件卖方相关的权利。如果您所在国家/地区的法律不允许本协议改变您所在国家/地区法律赋予您的权利，则本协议将不改变您按照所在国家/地区的法律应享有的权利。\n\n十一、保证免责条款\n\n该软件按“现状”授予许可。您须自行承担使用该软件的风险。库链不提供任何明示保证、保障或条件。根据您当地的法律，您可能享有本协议无法改变的其他消费者权利或法定保障。在您当地法律允许的范围内，库链排除有关适销性、针对特定目的的适用性和不侵权的默示保证。"

    lazy var txtLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()

    lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        var tipStr : String?

        if self.type == .service {
            tipStr = serviceStr
            self.title = "服务条款"
        } else {
            tipStr = privacyStr
            self.title = "隐私政策"
        }

        scrollView.frame = self.view.frame
        let height = self.height(text: tipStr!)

        scrollView.contentSize = CGSize(width: SCREEN_WIDTH, height: height + kTabBarHeight + 20)
        view.addSubview(scrollView)

        txtLabel.lineBreakMode = .byWordWrapping
        let attributedString:NSMutableAttributedString = NSMutableAttributedString(string: tipStr!)

        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, tipStr!.count))
        txtLabel.attributedText = attributedString
        txtLabel.sizeToFit()

        txtLabel.frame = CGRect(x: 20, y: 0, width: SCREEN_WIDTH - 40, height: height + 40)
        scrollView.addSubview(txtLabel)

    }


    /// 计算富文本高度
    func height(text: String) -> CGFloat {        // 注意这里的宽度计算，要根据自己的约束来计算
            let maxSize = CGSize(width: (SCREEN_WIDTH - 40), height: CGFloat(MAXFLOAT))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            paragraphStyle.lineBreakMode = .byWordWrapping
            paragraphStyle.lineSpacing = 8.0
            let labelSize = NSString(string: text).boundingRect(with: maxSize,
                                                                options: [.usesFontLeading, .usesLineFragmentOrigin],
                                                                attributes:[.font : UIFont.ThemeFont.HeadRegular, .paragraphStyle: paragraphStyle],
                                                                context: nil).size
            return labelSize.height
    }

}
