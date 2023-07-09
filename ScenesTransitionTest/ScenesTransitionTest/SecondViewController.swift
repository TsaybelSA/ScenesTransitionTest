//
//  SecondViewController.swift
//  ScenesTransitionTest
//
//  Created by Сергей Цайбель on 09.07.2023.
//

import UIKit

class SecondViewController: UIViewController {
    private var displayLink: CADisplayLink?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.frame = CGRect(x: 50, y: 400, width: 50, height: 20)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(Self.classForCoder()) \(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("\(Self.classForCoder()) \(#function)")
    }
    
    @objc
    private func closeAction() {
        dismiss(animated: true)
    }

}
