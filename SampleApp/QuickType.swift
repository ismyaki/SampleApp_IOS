//
//  QuickType.swift
//  SampleApp
//
//  Created by Aki Wang on 2021/7/2.
//

import Foundation

var ud: UserDefaultsManager { UserDefaultsManager.getInstance() }

var db: Database { Database.getInstance() }
class Database: NSObject {
    private static let recordInstance = Database()
    static private var instance : Database { return recordInstance }
    @objc static func getInstance() -> Database { return instance }
    
    var bikeStation : BikeStationManager { BikeStationManager.getInstance() }
}
