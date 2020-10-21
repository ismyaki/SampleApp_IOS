//
//  UIViewControllerExt.swift
//  TRAQ
//
//  Created by Aki Wang on 2020/3/13.
//  Copyright © 2020 smartq. All rights reserved.
//

import SwifterSwift
import Foundation
import UIKit

extension UIViewController {
    var keyWindow: UIWindow? { return UIApplication.shared.windows.first { $0.isKeyWindow } }
    var topSafeArea: CGFloat { return keyWindow?.safeAreaInsets.top ?? 0.0 }
    var bottomSafeArea: CGFloat { return keyWindow?.safeAreaInsets.bottom ?? 0.0 }
    var screenWidth: CGFloat { return keyWindow?.width ?? 0.0 }
    var screenHeight: CGFloat { return keyWindow?.height ?? 0.0 }
    var screenSafeWidth: CGFloat { return screenWidth }
    var screenSafeHeight: CGFloat { return screenHeight - (topSafeArea + bottomSafeArea) }
    
    static func loadFromNib(bundle: Bundle? = nil) -> Self {
//        self.progressVc = AlertProgressViewController(nibName: "AlertProgressViewController", bundle: nil)
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: bundle)
        }
        let vc: Self = instantiateFromNib()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
}
