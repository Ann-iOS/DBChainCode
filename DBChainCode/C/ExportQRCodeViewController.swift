//
//  ExportQRCodeViewController.swift
//  DBChainCode
//
//  Created by iOS on 2021/7/16.
//

import UIKit
import swiftScan

class ExportQRCodeViewController: UIViewController {

    var qrCodeStr: String = ""{
        didSet{
            print("生成二维码数据: \(qrCodeStr)")
        qrcodeImgV.image = LBXScanWrapper.createCode(codeType: "CIQRCodeGenerator", codeString: qrCodeStr, size: CGSize(width: 234, height: 234), qrColor: .black, bkColor: .white)
        }
    }

    lazy var scanImgV : UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "export_scan_tip")
        return imgV
    }()

    lazy var tipLabel : UILabel = {
        let label = UILabel()
        label.text = "扫描二维码"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont().themeHNMediumFont(size: 22)
        return label
    }()

    lazy var qrcodeImgV : UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()

    lazy var bottomLabel : UILabel = {
        let label = UILabel()
        label.text = "在您的新设备上下载库链验证器应用，然后使用该应用扫描此二维码。"
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    lazy var nextBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("下一步", for: .normal)
        btn.extSetCornerRadius(8)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.backgroundColor = .colorWithHexString(ThemeMainColor)
        btn.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(cancelExportCodeClick))
        view.addSubViews([scanImgV,tipLabel,qrcodeImgV,bottomLabel,nextBtn])

        scanImgV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
            make.width.height.equalTo(80)
        }

        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(scanImgV.snp.bottom).offset(18)
        }

        qrcodeImgV.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLabel.snp.bottom).offset(24)
            make.width.height.equalTo(234)
        }
        bottomLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(qrcodeImgV.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }

        nextBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-55)
            make.height.equalTo(54)
            make.width.equalTo(160)
        }
    }

    @objc func cancelExportCodeClick(){
        self.navigationController?.popViewController(animated: true)
    }

    @objc func nextButtonClick() {
        let vc = DeleteExportCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
