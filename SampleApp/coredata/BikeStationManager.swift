//
//  LocationManager.swift
//  ChargerApp
//
//  Created by Aki Wang on 2020/10/13.
//

import Foundation
import CoreData
import UIKit

class BikeStationManager: NSObject{
    private static let recordInstance = BikeStationManager()
    static private var instance : BikeStationManager { return recordInstance }
    @objc static func getInstance() -> BikeStationManager { return instance }
    
    let entityName = "BikeStationEntity"
    
    let persistentContainer: NSPersistentContainer!
    lazy var backgroundContext: NSManagedObjectContext = {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.persistentStoreCoordinator = self.persistentContainer.persistentStoreCoordinator
        return privateContext
//        return self.persistentContainer.newBackgroundContext()
    }()
    
    //MARK: Init with dependency
    private override init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.persistentContainer = appDelegate.mockPersistantContainer
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func newEntity() -> BikeStationEntity? {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: backgroundContext) as? BikeStationEntity
    }
    
    //MARK: CRUD
    func insert(dict: [String: TapipeiYouBikeStationModel.RetVal]) -> [BikeStationEntity] {
        var results = [BikeStationEntity]()
        for model in dict {
            var entity = fetch(id: model.value.sno ?? "")
            if entity == nil { entity = newEntity() }
            if let entity = entity {
                entity.sno = model.value.sno ?? ""
                entity.sna = model.value.sna ?? ""
                entity.lat = model.value.lat?.toDouble() ?? 0.0
                entity.lng = model.value.lng?.toDouble() ?? 0.0
                entity.sbi = model.value.sbi?.toInt64() ?? 0
                entity.tot = model.value.tot?.toInt64() ?? 0
                results.append(entity)
            }
        }
        return results
    }
    
    func remove(entity: BikeStationEntity) {
        backgroundContext.delete(entity)
    }
    
    func remove(arr: [BikeStationEntity]) {
        for entity in arr{
            remove(entity: entity)
        }
    }
    
    func removeAll() {
        remove(arr: fetchAll())
    }
    
    func fetchAll() -> [BikeStationEntity] {
        let request: NSFetchRequest<BikeStationEntity> = BikeStationEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "sno", ascending: false)]
        let results = try? backgroundContext.fetchByPerformAndWait(request)
        return results ?? [BikeStationEntity]()
    }
    
    func fetch(id: String) -> BikeStationEntity? {
        let request: NSFetchRequest<BikeStationEntity> = BikeStationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "sno = %@", id)
        let results = try? backgroundContext.fetchByPerformAndWait(request)
        return results?.count ?? [BikeStationEntity]().count > 0 ? results?[0] : nil
    }
    
    func fetchActive() -> [BikeStationEntity] {
        let request: NSFetchRequest<BikeStationEntity> = BikeStationEntity.fetchRequest()
        request.predicate = NSPredicate(format: "act = 1")
        request.sortDescriptors = [NSSortDescriptor(key: "sno", ascending: false)]
        let results = try? backgroundContext.fetchByPerformAndWait(request)
        return results ?? [BikeStationEntity]()
    }

    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.saveByPerformAndWait()
            } catch {
                print("Save error \(error)")
            }
        }
    }
}
