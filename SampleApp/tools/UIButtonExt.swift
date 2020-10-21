//
//  ButtonExt.swift
//  TRAQ
//
//  Created by Aki Wang on 2019/11/11.
//  Copyright © 2019 smartq. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    private var isAddTarget: Bool {
        get { return self.layer.value(forKey: "isAddTarget") as? Bool ?? false }
        set(value) {
            self.layer.setValue(value, forKey: "isAddTarget")
        }
    }
    
    private var extTextColor: UIColor? {
        get { return self.layer.value(forKey: "extTextColor") as? UIColor ?? self.titleColor(for: .normal) }
        set(value) {
            self.layer.setValue(value, forKey: "extTextColor")
        }
    }
    
    private var extBgColor: UIColor? {
        get { return self.layer.value(forKey: "extBgColor") as? UIColor ?? self.backgroundColor }
        set(value) {
            self.layer.setValue(value, forKey: "extBgColor")
        }
    }
    
    private var extBorderColor: UIColor? {
        get { return self.layer.value(forKey: "extBorderColor") as? UIColor ?? self.borderColor }
        set(value) {
            self.layer.setValue(value, forKey: "extBorderColor")
        }
    }
    
    private var extBorderWidth: CGFloat? {
        get { return self.layer.value(forKey: "extBorderWidth") as? CGFloat ?? self.borderWidth }
        set(value) {
            self.layer.setValue(value, forKey: "extBorderWidth")
        }
    }
    
    private var extCornerRadius: CGFloat? {
        get { return self.layer.value(forKey: "extCornerRadius") as? CGFloat ?? self.layer.cornerRadius }
        set(value) {
            self.layer.setValue(value, forKey: "extCornerRadius")
        }
    }
    
    private var touchTextColor: UIColor? {
        get { return self.layer.value(forKey: "touchTextColor") as? UIColor ?? self.titleColor(for: .normal) }
        set(value) {
            self.layer.setValue(value, forKey: "touchTextColor")
        }
    }
    
    private var touchBgColor: UIColor? {
        get { return self.layer.value(forKey: "touchBgColor") as? UIColor ?? self.backgroundColor }
        set(value) {
            self.layer.setValue(value, forKey: "touchBgColor")
        }
    }
    
    private var touchBorderColor: UIColor? {
        get { return self.layer.value(forKey: "touchBorderColor") as? UIColor ?? self.borderColor }
        set(value) {
            self.layer.setValue(value, forKey: "touchBorderColor")
        }
    }
    
    private var touchBorderWidth: CGFloat? {
        get { return self.layer.value(forKey: "touchBorderWidth") as? CGFloat }
        set(value) {
            self.layer.setValue(value, forKey: "touchBorderWidth")
        }
    }
    
    private var touchCornerRadius: CGFloat? {
        get { return self.layer.value(forKey: "touchCornerRadius") as? CGFloat ?? self.layer.cornerRadius }
        set(value) {
            self.layer.setValue(value, forKey: "touchCornerRadius")
        }
    }
    
    func setStyle(
        extTextColor: UIColor, extBgColor: UIColor, extBorderColor:UIColor, extBorderWidth: CGFloat, extCornerRadius: CGFloat,
        touchTextColor: UIColor, touchBgColor: UIColor, touchBorderColor:UIColor, touchBorderWidth: CGFloat, touchCornerRadius: CGFloat
        ) {
        self.extTextColor = extTextColor
        self.extBgColor = extBgColor
        self.extBorderColor = extBorderColor
        self.extBorderWidth = extBorderWidth
        self.extCornerRadius = extCornerRadius
        self.touchTextColor = touchTextColor
        self.touchBgColor = touchBgColor
        self.touchBorderColor = touchBorderColor
        self.touchBorderWidth = touchBorderWidth
        self.touchCornerRadius = touchCornerRadius
        setEvent()
        touchUp()
    }

    
    private func setEvent(){
        if isAddTarget == true {
            return
        }
        isAddTarget = true
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
    }
    
    @objc func touchDown(){
        self.setTitleColor(touchTextColor, for: .normal)
        self.setTitleColor(touchTextColor, for: .highlighted)
        self.layer.borderWidth = touchBorderWidth ?? borderWidth
        self.borderColor = touchBorderColor ?? borderColor
        self.backgroundColor = touchBgColor ?? self.backgroundColor
        self.layer.cornerRadius = touchCornerRadius ?? self.layer.cornerRadius
    }

    @objc func touchUp(){
        self.setTitleColor(extTextColor, for: .normal)
        self.setTitleColor(extTextColor, for: .highlighted)
        self.layer.borderWidth = extBorderWidth ?? borderWidth
        self.borderColor = extBorderColor ?? borderColor
        self.backgroundColor = extBgColor ?? self.backgroundColor
        self.layer.cornerRadius = extCornerRadius ?? self.layer.cornerRadius
    }
    
}
