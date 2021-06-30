//
//  TabBarController.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
           // Always adopt a light interface style.
           overrideUserInterfaceStyle = .light
       }
        initTab()
    }

    private func initTab(){
        // 設定 item
        var arr = [UIViewController]()
        
        if let vc = UIStoryboard(name: "Tab1", bundle:nil).instantiateViewController(withClass: StationViewController.self) {
            vc.tabBarItem =
                UITabBarItem(title: "Station",image: UIImage(systemName: "bicycle.circle"),selectedImage: UIImage(systemName:"bicycle.circle"))
            arr.append(vc)
        }
        
        if let vc = UIStoryboard(name: "Tab2", bundle:nil).instantiateViewController(withClass: Tab2ViewController.self) {
            vc.tabBarItem =
                UITabBarItem(title: "TAB2",image: UIImage(systemName: "bicycle.circle"),selectedImage: UIImage(systemName:"bicycle.circle"))
            arr.append(vc)
        }
        
        if let vc = UIStoryboard(name: "Tab3", bundle:nil).instantiateViewController(withClass: StationGridViewController.self) {
            vc.tabBarItem =
                UITabBarItem(title: "TAB3",image: UIImage(systemName: "bicycle.circle"),selectedImage: UIImage(systemName:"bicycle.circle"))
            arr.append(vc)
        }
        
        // set view contriller
        self.viewControllers = arr
        // setting tab ber style
        //去除 tab bar 上方黑線
        tabBar.layer.borderWidth = 0
        tabBar.clipsToBounds = true
        //設定selected and unselected icon 顏色
        tabBar.tintColor = .def_tab_selected
        tabBar.unselectedItemTintColor = .def_tab_unselected
        //
        chingeTabItemBackground(tabBar, selectedIndex, .def_tab_bg_selected)
    }

    private func chingeTabItemBackground(_ tabBar: UITabBar, _ tabIndex: Int, _ backgroundColor: UIColor) {
        tabBar.subviews.filter({ $0.layer.name == "bgView" }).first?.removeFromSuperview()
        tabBar.subviews.filter({ $0.layer.name == "topLineView" }).first?.removeFromSuperview()
        if let items = tabBar.items {
            let tabIndex = CGFloat(tabIndex)
            let tabWidth = tabBar.bounds.width / CGFloat(items.count)
            //
            let bgView = UIView(frame: CGRect(x: tabWidth * tabIndex, y: 0, width: tabWidth, height: 1000))
            bgView.backgroundColor = backgroundColor
            bgView.layer.name = "bgView"
            tabBar.insertSubview(bgView, at: 0)
            //
            let border = CALayer()
            border.backgroundColor = UIColor.def_tab_selected.cgColor
            border.frame = CGRect(x: 0, y: 0, width: bgView.frame.width, height: 3)
            bgView.layer.addSublayer(border)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        log(TAG, "\(item.title)")
        chingeTabItemBackground(tabBar, tabBar.items?.firstIndex(of: item) ?? 0, .def_tab_bg_selected)
    }
}
