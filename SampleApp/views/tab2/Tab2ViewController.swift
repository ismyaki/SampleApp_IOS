//
//  Tab2ViewController.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/22.
//

import UIKit

class Tab2ViewController: BaseViewController {
    
    @IBOutlet weak var btnGoToSecond: UIButton!
    
    private var dataList = [BikeStationEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initData()
        initView()
        setValue()
    }
    
    private func initData(){
        dataList = BikeStationManager.getInstance().fetchAll()
        log(TAG, "dataList.count is \(dataList.count)")
        dataList.forEach() {
            log(TAG, "\($0.sno ?? "") \($0.sna ?? "")")
        }
    }
    
    private func initView(){
        
    }
    
    private func setValue(){
        
    }
    

    @IBAction func onClickGoToSecond(){
        if let next = storyboard?.instantiateViewController(withClass: SecondViewController.self) {
            next.modalPresentationStyle = .fullScreen
            self.present(next, animated: true, completion: nil)
        }
    }

}
