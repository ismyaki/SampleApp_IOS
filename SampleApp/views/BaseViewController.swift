//
//  BaseViewController.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/22.
//

import UIKit

class BaseViewController: UIViewController {
    lazy var TAG = String(describing: type(of: self))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.def_bg_1 //UIColor(hex: 0x000000, transparency: 0)
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        // Do any additional setup after loading the view.
    }
}
