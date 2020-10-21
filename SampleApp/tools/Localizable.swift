//
//  Localizable.swift
//  SmatCubeProtoType
//
//  Created by Aki Wang on 2019/6/24.
//  Copyright © 2019 smartq. All rights reserved.
//

import Foundation
import UIKit

//protocol Localizable {
//    var localized: String { get }
//}
//
//extension String: Localizable {
//    var localized: String {
//        return NSLocalizedString(self, comment: "")
//    }
//}


extension String {
    var localized: String {
        let lang = UserDefaultsManager.getInstance().getLang()
        if lang == "" {
            return NSLocalizedString(self, comment:"")
        } else if let path = Bundle.main.path(forResource: lang, ofType: "lproj") , let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        }else {
            return NSLocalizedString(self, comment:"")
        }
    }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
    var xibLocHintKey: String? { get set }
}

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
    
    @IBInspectable var xibLocHintKey: String? {
        get { return nil }
        set(key) {
//            placeholder = key?.localized
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
    
    @IBInspectable var xibLocHintKey: String? {
        get { return nil }
        set(key) {
//            placeholder = key?.localized
        }
    }
}

extension UITextField: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
    
    @IBInspectable var xibLocHintKey: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized
        }
    }
}

extension UITabBarItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
    
    @IBInspectable var xibLocHintKey: String? {
        get { return nil }
        set(key) {
//            placeholder = key?.localized
        }
    }
}
