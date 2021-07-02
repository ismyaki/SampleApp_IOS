//
//  StationViewController.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/22.
//

import UIKit
import CoreData

class StationViewController: BaseViewController {
    
    @IBOutlet weak var tvStation: UITableView!
    
    private var dataList = [BikeStationEntity]()
    private lazy var dataResults = { db.bikeStation.fetchAllInLive() }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initData()
        initView()
    }
    
    private func initData(){
        dataList = db.bikeStation.fetchAll()
        log(TAG, "dataList.count \(dataList.count)")
        dataResults.delegate = self
    }
    
    private func initView(){
        tvStation.apply {
            $0.delegate = self
            $0.dataSource = self
            $0.reloadData()
        }
    }
}

extension StationViewController: UITableViewDataSource, UITableViewDelegate, StationTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataResults.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: StationTableViewCell.self, for: indexPath)
        cell.delegate = self
        cell.setValue(entity: dataResults.object(at: indexPath))
        return cell
    }
    
    func onClickCopy(_ view: UIView, selectEntity: BikeStationEntity) {
        let date = Date().toString("HH:mm:ss")
        let _ = db.bikeStation.insert(
            sno: (selectEntity.sno ?? "") + date,
            sna: (selectEntity.sna ?? "") + date,
            lat: selectEntity.lat,
            lng: selectEntity.lng,
            sbi: selectEntity.sbi.toInt(),
            tot: selectEntity.tot.toInt()
        )
        db.bikeStation.save()
    }
    
    func onClickDel(_ view: UIView, selectEntity: BikeStationEntity) {
        db.bikeStation.remove(entity: selectEntity)
        db.bikeStation.save()
    }
    
}

extension StationViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == dataResults {
            log(TAG, "controllerWillChangeContent \(dataResults.sections?[0].numberOfObjects ?? 0)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if controller == dataResults {
            log(TAG, "controllerDidChangeContent \(dataResults.sections?[0].numberOfObjects ?? 0)")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if controller == dataResults {
            switch type {
            case .insert:
                log(TAG, "insert \(dataResults.sections?[0].numberOfObjects ?? 0)")
                if let newIndexPath = newIndexPath {
                    tvStation.insertRows(at: [newIndexPath], with: .automatic)
                }
                break
            case .update:
                log(TAG, "update \(dataResults.sections?[0].numberOfObjects ?? 0)")
                if let indexPath = indexPath {
                    tvStation.reloadRows(at: [indexPath], with: .automatic)
                }
                break
            case .delete:
                log(TAG, "delete \(dataResults.sections?[0].numberOfObjects ?? 0)")
                if let indexPath = indexPath {
                    tvStation.deleteRows(at: [indexPath], with: .automatic)
                }
                break
            case .move:
                log(TAG, "move \(dataResults.sections?[0].numberOfObjects ?? 0)")
                if let newIndexPath = newIndexPath, let indexPath = indexPath {
                    tvStation.deleteRows(at: [indexPath], with: .automatic)
                    tvStation.insertRows(at: [newIndexPath], with: .automatic)
                }
                break
            default:
                break
            }
        }
    }
}
