//
//  UIImageViewExtension.swift
//  SDJG
//
//  Created by 王俊 on 16/4/19.
//  Modify  by 王俊 on 17/6/5. swift3.0
//  Copyright © 2016年 sunlands. All rights reserved.
//

import UIKit

extension UIImageView {
    
    
    /**
     设置图片名称
     
     - parameter imageName: 图片名称
     */
    public final func extSetImageName(_ imageName : String){
        
        self.image = UIImage.init(named: imageName)
        
    }
    
    private struct AssociatedKeys {
        static var topNameKey = "topNameKey"
        static var leftNameKey = "leftNameKey"
        static var bottomNameKey = "bottomNameKey"
        static var rightNameKey = "rightNameKey"
    }
    
    /**
     扩大按钮点击范围
     
     - parameter top:    顶部扩大多少
     - parameter left:   左边扩大多少
     - parameter bottom: 底部扩大多少
     - parameter right:  右边扩大多少
     */
    public func setEnlargeEdgeWithTop(_ top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        
        objc_setAssociatedObject(self, &AssociatedKeys.topNameKey, NSNumber.init(value: Float(top)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        
        objc_setAssociatedObject(self, &AssociatedKeys.leftNameKey, NSNumber.init(value: Float(left)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        
        objc_setAssociatedObject(self, &AssociatedKeys.bottomNameKey, NSNumber.init(value: Float(bottom)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        
        objc_setAssociatedObject(self, &AssociatedKeys.rightNameKey, NSNumber.init(value: Float(right)), objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        
    }
    
    /**
     把点击范围设置成size大小
     
     - parameter size: 调整后的点击范围的大小
     */
    public func setTouchAreaToSize(_ size: CGSize) {
        var top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0
        if size.width > self.frame.size.width {
            left = (size.width - self.frame.size.width) / 2
            right = left
        }
        
        if (size.height > self.frame.size.height) {
            top = (size.height - self.frame.size.height) / 2
            bottom = top
        }
        setEnlargeEdgeWithTop(top, left: left, bottom: bottom, right: right)
    }
    
    public func enlargedRect() -> CGRect {
        
        let topEdge = objc_getAssociatedObject(self, &AssociatedKeys.topNameKey) as? NSNumber
        let rightEdge = objc_getAssociatedObject(self, &AssociatedKeys.rightNameKey) as? NSNumber
        let bottomEdge = objc_getAssociatedObject(self, &AssociatedKeys.bottomNameKey) as? NSNumber
        let leftEdge = objc_getAssociatedObject(self, &AssociatedKeys.leftNameKey) as? NSNumber
        
        if topEdge != nil && rightEdge != nil && bottomEdge != nil && leftEdge != nil {
            return
                CGRect(x:self.bounds.origin.x - CGFloat.init(truncating: leftEdge!),
                       y:self.bounds.origin.y - CGFloat.init(truncating: topEdge!),
                       width:self.bounds.size.width + CGFloat.init(truncating:leftEdge!) + CGFloat.init(truncating:rightEdge!),
                       height:self.bounds.size.height + CGFloat.init(truncating:topEdge!) + CGFloat.init(truncating:bottomEdge!))
        } else {
            return self.bounds
        }
    }
    
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let rect = self.enlargedRect()
        if rect.equalTo(self.bounds) || self.isHidden {
            return super.hitTest(point, with: event)
        }
        if rect.contains(point) {
            return self
        } else {
            return nil
        }
    }
    
    //MARK:根据image的形状裁剪imageView
    func cutOutTriangleImgV(_ originImageView : UIImageView , _ accordImage : UIImage , _ edgeInset : UIEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)){
        // 新建一个图层
        let layer = CALayer()
        
        var img = accordImage
        img = img.resizableImage(withCapInsets: edgeInset)
        
        // 设置图层显示的内容为拉伸过的MaskImgae
        layer.contents = img.cgImage
        //        layer.contents = UIImage.init(mNamed: "talkmessage/talkmessage_message_whiteMessageBox")?.cgImage
        
        // 设置拉伸范围(注意：这里contentsCenter的CGRect是比例（不是绝对坐标）)
        layer.contentsCenter = self.CGRectCenterRectForResizableImage(img)
        
        // 设置图层大小与chatImgView相同
        layer.frame = CGRect(x: 0, y: 0, width: originImageView.bounds.width, height: originImageView.bounds.height)
        
        // 设置比例
        layer.contentsScale = UIScreen.main.scale
        
        // 设置不透明度
        layer.opacity = 1
        
        // 设置裁剪范围
        originImageView.layer.mask = layer
        
        // 设置裁剪掉超出的区域
        originImageView.layer.masksToBounds = true
        
    }
    
    func CGRectCenterRectForResizableImage(_ image: UIImage) -> CGRect{
        
        return CGRect(x: image.capInsets.left / image.size.width,y: image.capInsets.top / image.size.height,width: (image.size.width - image.capInsets.right - image.capInsets.left) / image.size.width,height: (image.size.height - image.capInsets.bottom - image.capInsets.top) / image.size.height)
    }
    
//    func setImageWithUrl(path:String,text:String) {
//        
//        if let url = URL.init(string: path){
//            self.yy_setImage(with: url, placeholder:nil)
//        }else{
//            if text.count > 0 {
//                let nameImg = UIImage.getTextImage(drawText: String(text.prefix(1)), size: CGSize(width: 26, height: 26))
//                self.image = nameImg
//            }else {
//                self.image =  UIImage.themeImageNamed(imageName: "headportrait")
//            }
//        }
//    }

}
