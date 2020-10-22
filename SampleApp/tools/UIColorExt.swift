//
//  UIColorExt.swift
//  TRAQ
//
//  Created by Aki Wang on 2019/11/8.
//  Copyright © 2019 smartq. All rights reserved.
//

import SwifterSwift
import Foundation
import UIKit

extension UIColor {
    static let transparent = "transparent".toColorByNamed()
    //    static let white = "white".toColorByNamed()
    //    /** Color[000000] */
    //    static let black = "black".toColorByNamed()
    //    static let red = "red".toColorByNamed()
    //    static let green = "green".toColorByNamed()
    //    static let blue = "blue".toColorByNamed()
    //    static let yellow = "yellow".toColorByNamed()
    
    /** Color[FFFFFF] */
    static let def_bg_1 = "def_bg_1".toColorByNamed()
    /** Color[EEF1F5] */
    static let def_bg_2 = "def_bg_2".toColorByNamed()
    /** Color[FFFFFF] */
    static let def_btn_bg_1 = "def_btn_bg_1".toColorByNamed()
    /** Color[0084FF] */
    static let def_btn_bg_2 = "def_btn_bg_2".toColorByNamed()
    /** Color[DADADA] */
    static let def_btn_border_1 = "def_btn_border_1".toColorByNamed()
    /** Color[0084FF] */
    static let def_btn_border_2 = "def_btn_border_2".toColorByNamed()
    /** Color[FFFFFF] */
    static let def_btn_bg = "def_btn_bg".toColorByNamed()
    /** Color[00AD97] */
    static let def_btn_border = "def_btn_border".toColorByNamed()
    /** Color[00AD97] */
    static let def_btn_txt = "def_btn_txt".toColorByNamed()
    /** Color[00AD97] */
    static let def_btn_bg_touch = "def_btn_bg_touch".toColorByNamed()
    /** Color[00AD97] */
    static let def_btn_border_touch = "def_btn_border_touch".toColorByNamed()
    /** Color[FFFFFF] */
    static let def_btn_txt_touch = "def_btn_txt_touch".toColorByNamed()
    /** Color[FFFFFF]  */
    static let def_btn2_bg = "def_btn2_bg".toColorByNamed()
    /** Color[BBBBBB]  */
    static let def_btn2_border = "def_btn2_border".toColorByNamed()
    /** Color[222222] */
    static let def_btn2_txt = "def_btn2_txt".toColorByNamed()
    /** Color[D8D8D8] */
    static let def_btn2_bg_touch = "def_btn2_bg_touch".toColorByNamed()
    /** Color[BBBBBB]  */
    static let def_btn2_border_touch = "def_btn2_border_touch".toColorByNamed()
    /** Color[222222]  */
    static let def_btn2_txt_touch = "def_btn2_txt_touch".toColorByNamed()
    /** Color[0084ff] */
    static let def_tab_selected = "def_tab_selected".toColorByNamed()
    /** Color[d4e2f4] */
    static let def_tab_unselected = "def_tab_unselected".toColorByNamed()
    /** Color[f5faff] */
    static let def_tab_bg_selected = "def_tab_bg_selected".toColorByNamed()
    /** Color[FFFFFF] */
    static let def_tab_bg_unselected = "def_tab_bg_unselected".toColorByNamed()
    
}

func UIColorFromRGB(_ hex: Int, _ alpha: CGFloat = 1) -> UIColor {
    return UIColor(hex: hex, transparency: alpha) ?? UIColor(red: 1, green: 1, blue: 1, alpha: 1)
}

func UIColorFromARGB(_ hex: Int) -> UIColor {
    return UIColor(hex: hex) ?? UIColor(red: 1, green: 1, blue: 1, alpha: 1)
}

extension Int{
    func toColor(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: self, transparency: alpha) ?? UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
}

extension String{
    func toColorByNamed() -> UIColor {
        return UIColor(named: self) ?? UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
