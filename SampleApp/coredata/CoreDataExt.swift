//
//  CoreDataExt.swift
//  TRAQ
//
//  Created by Aki Wang on 2019/12/16.
//  Copyright © 2019 smartq. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {
    func fetchByPerformAndWait<T>(_ request: NSFetchRequest<T>) throws -> [T] where T : NSFetchRequestResult {
        var results = [T]()
        if self.hasChanges {
            do {
                try self.saveByPerformAndWait()
            } catch {
                print("Save error \(error)")
            }
        }
        synchronized(self){
            do {
                try self.performAndWait  {
                    do {
                        results = try self.fetch(request)
                    } catch {
                        print("Save error \(error)")
                    }
                }
            } catch {
                print("Save error \(error)")
            }
        }
        return results
    }
    
    func saveByPerformAndWait() throws {
        synchronized(self) {
            do {
                try self.performAndWait {
                    if self.hasChanges {
                        do {
                            try self.save()
                        } catch {
                            print("Save error \(error)")
                        }
                    }
                }
            } catch {
                print("Save error \(error)")
            }
        }
    }
}
