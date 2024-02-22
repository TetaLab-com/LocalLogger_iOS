//
//  LogDatabase.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import Foundation
import CoreData

class LogDatabase {
    static let shared = LogDatabase()
    
    private(set) var currentSession: SessionDB?
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LogDB")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()

    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    public func startSession() {
        currentSession = SessionDB(context: viewContext)
        currentSession!.date = Date()
        
        saveContext()
    }
    
    public func saveLog(_ log: Log) {
        guard let currentSession else {
            print("[Info][LogDatabase] tried to save log, but session isn't started")
            return
        }
        
        let log = log.toLogDB()
        currentSession.addToLogs(log)
        
        saveContext()
    }
    
    public func saveLogs(_ logs: [Log]) {
        guard let currentSession else {
            print("[Info][LogDatabase] tried to save logs, but session isn't started")
            return
        }
        
        let logs = logs.toLogsDB()
        logs.forEach(currentSession.addToLogs)
        
        saveContext()
    }
    
    public func fetchLogs() -> [LogDB] {
        let request = LogDB.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let items = try viewContext.fetch(request)
            return items
        } catch {
            print("[Error][LogDatabase] fetchLogs: \(error)")
            return []
        }
    }
    
    public func fetchSessions() -> [SessionDB] {
        let request = SessionDB.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let items = try viewContext.fetch(request)
            return items
        } catch {
            print("[Error][LogDatabase] fetchSessions: \(error)")
            return []
        }
    }

    private func saveContext() {
        guard viewContext.hasChanges else {
            return
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
