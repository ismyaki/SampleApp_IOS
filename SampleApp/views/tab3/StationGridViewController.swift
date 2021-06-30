//
//  Tab3ViewController.swift
//  SampleApp
//
//  Created by Aki Wang on 2021/6/29.
//

import UIKit

class StationGridViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    }
    
    private func initView(){
        collectionView.apply {
            let layout = FlowLayout()
            layout.rowCount = 3
            layout.maxCount = dataList.count
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 10.0
            layout.computeSize = { index -> CGSize in
                let sno = self.dataList[index].sno?.toInt() ?? 0
                let width = (self.collectionView.bounds.size.width / 3) - layout.minimumInteritemSpacing
                let height = 100 + ((sno % 4) * 50)
                return CGSize(width: CGFloat(width), height: CGFloat(height))
            }
            $0.setCollectionViewLayout(layout, animated: false)
            
            $0.delegate = self
            $0.dataSource = self
            $0.reloadData()
        }
    }

}

extension StationGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: StationGridCollectionCell.self, for: indexPath)
        let data = dataList[indexPath.row]
        cell.setValue(indexPath: indexPath, entity: data)
        return cell
    }
}
