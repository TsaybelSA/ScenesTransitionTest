//
//  ViewController.swift
//  ScenesTransitionTest
//
//  Created by Сергей Цайбель on 08.07.2023.
//

import UIKit

class ViewController: UIViewController {
    let customTransitionDelegate = TransitioningDelegate()

    private var fromView: UIView?
    
    @IBOutlet weak var tappableImageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    private var displayLink: CADisplayLink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        tappableImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageAction))
        tappableImageView.layer.cornerRadius = 10
        tappableImageView.addGestureRecognizer(gesture)
    }
    
    @IBAction func buttonAction(_ sender: UIView) {
        let secondVC = SecondViewController()
        fromView = sender
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        present(secondVC, animated: true)
    }
    
    @objc
    private func imageAction() {
        guard let image = tappableImageView.image else { return }
        let secondVC = ImageViewController(image: image, initialSize: tappableImageView.bounds.size)
        fromView = tappableImageView
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
        present(secondVC, animated: true)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let fromView else { return nil }
        return CustomPresentAnimationController(originFrame: fromView.frame, viewRadius: fromView.layer.cornerRadius, duration: 1)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let fromView else { return nil }
        return CustomDismissAnimationController(finalFrame: fromView.frame, viewRadius: fromView.layer.cornerRadius, duration: 1)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
