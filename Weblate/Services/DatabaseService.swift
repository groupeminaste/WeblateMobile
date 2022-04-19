//
//  DatabaseService.swift
//  Weblate
//
//  Created by Nathan Fallet on 19/04/2022.
//

import Foundation
import SQLite

class DatabaseService {
    
    // Shared instance
    
    static let shared = DatabaseService()
    
    // Properties
    
    private var db: Connection?
    let version: Int32 = 1
    
    let instances = Table("instances")
    
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let host = Expression<String>("host")
    let token = Expression<String>("token")
    
    // Initializer
    
    init() {
        do {
            // Get database path
            if let path = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.me.nathanfallet.Weblate")?.path {
                // Connect to database
                db = try Connection("\(path)/weblate.sqlite3")
                
                // Check database version
                if let knownVersion = db?.userVersion, knownVersion != 0 {
                    if knownVersion < version {
                        // Upgrade database
                        try onUpgrade(oldVersion: knownVersion, newVersion: version)
                    }
                } else {
                    // Create database
                    try onCreate()
                }
                
                // Save version
                db?.userVersion = version
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Methods
    
    func onCreate() throws {
        // Initialize tables
        try db?.run(instances.create(ifNotExists: true) { table in
            table.column(id, primaryKey: .autoincrement)
            table.column(name)
            table.column(host)
            table.column(token)
        })
    }
    
    func onUpgrade(oldVersion: Int32, newVersion: Int32) throws {
        // Nothing to upgrade for now
    }
    
    func fetchInstances() -> [Instance] {
        do {
            return try db?.prepare(instances.select(id, name, host, token)).map { row in
                Instance(id: try row.get(id), name: try row.get(name), host: try row.get(host), token: try row.get(token))
            } ?? []
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func createInstance(instance: Instance) -> Int64 {
        guard instance.id == -1 else { return instance.id }
        
        do {
            return try db?.run(instances.insert(
                name <- instance.name.trim(),
                host <- instance.host.trim(),
                token <- instance.token.trim()
            )) ?? -1
        } catch {
            print(error.localizedDescription)
        }
        
        return -1
    }
    
}
