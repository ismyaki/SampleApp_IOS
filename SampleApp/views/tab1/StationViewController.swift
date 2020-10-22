//
//  Tab1ViewController.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/22.
//

import UIKit

class StationViewController: BaseViewController {
    
    @IBOutlet weak var tvStation: UITableView!
    
    private var dataList = [BikeStationEntity]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initData()
        initView()
    }
    
    private func initData(){
        dataList = BikeStationManager.getInstance().fetchAll()
        log(TAG, "dataList.count \(dataList.count)")
    }
    
    private func initView(){
        tvStation.delegate = self
        tvStation.dataSource = self
        tvStation.reloadData()
    }
}

extension StationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: StationTableViewCell.self, for: indexPath)
        cell.setValue(entity: dataList[indexPath.row])
        return cell
    }
}
