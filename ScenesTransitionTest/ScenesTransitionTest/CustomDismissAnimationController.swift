//
//  CustomDismissAnimationController.swift
//  ScenesTransitionTest
//
//  Created by Сергей Цайбель on 08.07.2023.
//

import UIKit

class CustomDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    private let finalFrame: CGRect
    private let viewRadius: CGFloat
    private let duration: TimeInterval
    
    init(finalFrame: CGRect, viewRadius: CGFloat, duration: TimeInterval) {
        self.finalFrame = finalFrame
        self.viewRadius = viewRadius
        self.duration = duration
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
          let toVC = transitionContext.viewController(forKey: .to),
          let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
          else {
            return
        }
        
        transitionContext.finalFrame(for: fromVC)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        fromVC.view.layer.sublayers?.first?.removeFromSuperlayer()
        fromVC.view.layer.cornerRadius = viewRadius
        
        let duration = transitionDuration(using: transitionContext)
        
        if let imageVC = fromVC as? ImageViewController {
            imageVC.adjustDismissAnimation(initialFrame: fromVC.view.frame, finalRect: finalFrame, duration: duration)
        }
        
        UIView.animate(withDuration: duration) {
            fromVC.view.frame = self.finalFrame
        } completion: { _ in
            toVC.view.isHidden = false
            snapshot.removeFromSuperview()
            fromVC.view.layer.transform = CATransform3DIdentity
            if transitionContext.transitionWasCancelled {
                toVC.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

class PresentationController: UIPresentationController {
    override var shouldRemovePresentersView: Bool { return true }
}
//
//class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
//
//    /// Interaction controller
//    ///
//    /// If gesture triggers transition, it will set will manage its own
//    /// `UIPercentDrivenInteractiveTransition`, but it must set this
//    /// reference to that interaction controller here, so that this
//    /// knows whether it's interactive or not.
//
//    weak var interactionController: UIPercentDrivenInteractiveTransition?
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return ScaleFromImageAnimationController(transitionType: .presenting)
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return ScaleFromImageAnimationController(transitionType: .dismissing)
//    }
//
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        return PresentationController(presentedViewController: presented, presenting: presenting)
//    }
//
//    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return interactionController
//    }
//
//    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return interactionController
//    }
//
//}
//
//class ScaleFromImageAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
//
//    enum TransitionType {
//        case presenting
//        case dismissing
//    }
//
//    let transitionType: TransitionType
//
//    init(transitionType: TransitionType) {
//        self.transitionType = transitionType
//
//        super.init()
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromVC = transitionContext.viewController(forKey: .from),
//          let toVC = transitionContext.viewController(forKey: .to),
//          let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
//          else {
//            return
//        }
//        let inView   = transitionContext.containerView
//        let toView   = toVC.view!
//        let fromView = fromVC.view!
//
//        var frame = inView.bounds
//
//        switch transitionType {
//        case .presenting:
//            frame.origin.y = -frame.size.height
//            toView.frame = frame
//
//            inView.addSubview(toView)
//            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//                toView.frame = inView.bounds
//            }, completion: { finished in
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            })
//        case .dismissing:
//            toView.frame = frame
//            inView.insertSubview(toView, belowSubview: fromView)
//
//            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//                frame.origin.y = -frame.size.height
//                fromView.frame = frame
//            }, completion: { finished in
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            })
//        }
//    }
//
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 5
//    }
//}
