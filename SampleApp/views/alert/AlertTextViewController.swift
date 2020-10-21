//
//  TextViewController.swift
//  SmatCubeProtoType
//
//  Created by Aki Wang on 2019/6/6.
//  Copyright © 2019 smartq. All rights reserved.
//

import UIKit
import SwifterSwift

class AlertTextViewController: UIViewController {
    var titleString: String? = nil
    var messageString: String? = nil
    var leftBtnString = "CANCEL".localized
    var rightBtnString = "OK".localized
    
    var onClickRight: (() -> ())?
    var onClickLeft: (() -> ())?
    var onViewDidLoad: (() -> ())?
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        // Do any additional setup after loading the view.
        onViewDidLoad?()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbTitle.text = titleString
        lbMessage.text = messageString
        btnLeft.setTitle(leftBtnString, for: .normal)
        btnRight.setTitle(rightBtnString, for: .normal)
        btnRight.setStyle(extTextColor: UIColor.def_btn_txt, extBgColor: UIColor.def_btn_bg, extBorderColor: UIColor.def_btn_border, extBorderWidth: 1, extCornerRadius: 24, touchTextColor: UIColor.def_btn_txt_touch, touchBgColor: UIColor.def_btn_bg_touch, touchBorderColor: UIColor.def_btn_border_touch, touchBorderWidth: 1, touchCornerRadius: 24)
        btnLeft.setStyle(extTextColor: UIColor.def_btn2_txt, extBgColor: UIColor.def_btn_bg, extBorderColor: UIColor.def_btn2_border_touch, extBorderWidth: 1, extCornerRadius: 24, touchTextColor: UIColor.def_btn_txt_touch, touchBgColor: UIColor.def_btn2_bg_touch, touchBorderColor: UIColor.def_btn2_border_touch, touchBorderWidth: 1, touchCornerRadius: 24)
    }
    
    @IBAction func onCleckRight(_ sender: UIButton) {
        self.onClickRight?()
    }
    
    @IBAction func onCleckLeft(_ sender: UIButton) {
        self.onClickLeft?()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
