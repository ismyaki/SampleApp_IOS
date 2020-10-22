//
//  LoginViewController.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/22.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickLogin(){
        let storyboard = UIStoryboard.init(name: "Tab", bundle: nil)
        if let next = storyboard.instantiateViewController(withClass: TabBarController.self) {
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: false)
        }
    }

}
