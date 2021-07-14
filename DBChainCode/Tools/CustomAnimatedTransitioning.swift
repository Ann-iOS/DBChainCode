//
//  CustomAnimatedTransitioning.swift
//  TranslateAinamate
//
//  Created by zhanghailong on 2020/2/25.
//  Copyright © 2020 future. All rights reserved.
//

import UIKit

class CustomAnimatedTransitioning: NSObject,UIViewControllerAnimatedTransitioning,CAAnimationDelegate {
    var _transitionContext:UIViewControllerContextTransitioning?
    var isPush:Bool?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        _transitionContext = transitionContext
        var Vc1:HomeViewController?
        var Vc2:AddCodeViewController?
        var btn:UIButton?

        if isPush == true {
            Vc1 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? HomeViewController
            Vc2 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? AddCodeViewController
            btn = Vc1?.addBtn
        } else {
            Vc2 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? AddCodeViewController
            Vc1 = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? HomeViewController
            btn = Vc2?.cancelBtn
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(Vc1!.view)
        containerView.addSubview(Vc2!.view)
        let path1 = UIBezierPath.init(ovalIn: btn!.frame)

        let path2 = UIBezierPath.init(arcCenter: btn!.center, radius: CGFloat(sqrtf(Float(btn!.center.x*btn!.center.x + btn!.center.y*btn!.center.y))), startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        print("\(Float(btn!.center.x*btn!.center.x + btn!.center.y*btn!.center.y))")

        
        let layer = CAShapeLayer.init()
        if isPush == true {
            layer.path = path2.cgPath
        } else {
            layer.path = path1.cgPath
        }

        var VC :UIViewController?
        if isPush == true {
            VC = transitionContext.viewController(forKey: .to)
        }
        else{
            VC = transitionContext.viewController(forKey: .from)
        }
        VC!.view.layer.mask = layer

        let ani = CABasicAnimation.init(keyPath: "path")
        if isPush == true {
            ani.fromValue = path1.cgPath as Any
        }
        else {
            ani.fromValue = path2.cgPath as Any
        }

        ani.delegate = self
        layer.add(ani, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        _transitionContext!.completeTransition(true)
        var VC:AddCodeViewController?
        if isPush == true {
            VC = _transitionContext!.viewController(forKey: UITransitionContextViewControllerKey.to) as? AddCodeViewController
        } else {
            VC = _transitionContext!.viewController(forKey: UITransitionContextViewControllerKey.from) as? AddCodeViewController
        }
        VC!.view.layer.mask = nil
        VC!.view.backgroundColor = .colorWithHexString("000000", alpha: 0.8)
    }
}
