//
//  ImageViewController.swift
//  ScenesTransitionTest
//
//  Created by Сергей Цайбель on 09.07.2023.
//

import UIKit

class ImageViewController: UIViewController {
    init(image: UIImage, initialSize: CGSize) {
        self.image = image
        self.initialSize = initialSize
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let image: UIImage
    private let initialSize: CGSize
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
        
    private var backgroundView: UIView = {
       let background = UIView()
        background.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return background
    }()
    
    private let maxSize = CGSize(width: 350, height: 500)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(backgroundView, at: 0)
        backgroundView.frame = view.frame
        backgroundView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        view.clipsToBounds = false
        
        view.addSubview(imageView)
        
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageAction))
        imageView.layer.cornerRadius = 10
        imageView.addGestureRecognizer(gesture)
        
    }
    
    func adjustImageFrame(initialFrame: CGRect, finalRect: CGRect, duration: TimeInterval) {
        print("adjustImageFrame")
        imageView.frame = CGRect(x: 0, y: 0, width: initialFrame.width, height: initialFrame.height)
        UIView.animate(withDuration: duration) { [self] in
            let aspectRatio = image.size.width / image.size.height
            
            let width = min(finalRect.width, maxSize.width)
            let height = width / aspectRatio
            let xOrigin = (finalRect.width - width) / 2
            let yOrigin = (finalRect.height - height) / 2
            imageView.frame = CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
        }
    }
    
    func adjustDismissAnimation(initialFrame: CGRect, finalRect: CGRect, duration: TimeInterval) {
        let aspectRatio = image.size.width / image.size.height
        
        let startWidth = min(initialFrame.width, maxSize.width)
        let startHeight = startWidth / aspectRatio
        let startXOrigin = (initialFrame.width - startWidth) / 2
        let startYOrigin = (initialFrame.height - startHeight) / 2
        imageView.frame = CGRect(x: startXOrigin, y: startYOrigin, width: startWidth, height: startHeight)
        
        UIView.animate(withDuration: duration) { [self] in
            imageView.frame = CGRect(x: 0, y: 0, width: finalRect.width, height: finalRect.height)
        }
    }
    
    @objc
    private func closeAction() {
        dismiss(animated: true)
    }
    
    @objc
    private func imageAction() {
        closeAction()
    }
}
