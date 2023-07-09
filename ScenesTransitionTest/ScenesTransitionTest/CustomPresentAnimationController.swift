//
//  CustomPresentAnimationController.swift
//  ScenesTransitionTest
//
//  Created by Сергей Цайбель on 08.07.2023.
//

import UIKit

class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    private let originFrame: CGRect
    private let viewRadius: CGFloat
    private let duration: CGFloat
    
    init(originFrame: CGRect, viewRadius: CGFloat, duration: TimeInterval) {
        self.originFrame = originFrame
        self.viewRadius = viewRadius
        self.duration = duration
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
          let toVC = transitionContext.viewController(forKey: .to),
          let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
          else {
            return
        }
        
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)

        toVC.view.frame = originFrame
        toVC.view.layer.cornerRadius = viewRadius
        toVC.view.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        
        let duration = transitionDuration(using: transitionContext)

        if let imageVC = toVC as? ImageViewController {
            imageVC.adjustImageFrame(initialFrame: self.originFrame, finalRect: finalFrame, duration: duration)
        }
        
        UIView.animate(withDuration: duration) {
            toVC.view.frame = finalFrame
        } completion: { _ in
            toVC.view.layer.insertSublayer(snapshot.layer, at: 0)
          fromVC.view.layer.transform = CATransform3DIdentity
          transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
