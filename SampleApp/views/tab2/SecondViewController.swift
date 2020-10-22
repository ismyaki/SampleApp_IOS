//
//  SecondViewController.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/21.
//

import UIKit

class SecondViewController: BaseViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    private func initData(){
        
    }
    
    private func initView(){
        
    }
    
    private func setValue(){
        
    }

    @IBAction func onClickBack(){
        dismiss(animated: true)
    }
}
