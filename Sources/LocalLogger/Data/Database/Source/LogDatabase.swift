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
    
    private lazy var persistentContainer: NSPersistentContainer? = {
        let bundle = Bundle.module
        guard
            let modelURL = bundle.url(forResource: "LogDB", withExtension: ".momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL)
        else {
            Log.logger.error("[Error][LogDatabase] persistentContainer: unable to find DB location")
            return nil
        }
        
        let container = NSPersistentCloudKitContainer(name: "LogDB", managedObjectModel: model)
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                Log.logger.error("E: [LogDatabase][persistentContainer] \(error)")
            }
        }
        
        return container
    }()

    public var viewContext: NSManagedObjectContext? {
        return persistentContainer?.viewContext
    }
    
    public func startSession() {
        guard let viewContext else {
            return
        }
        
        currentSession = SessionDB(context: viewContext)
        currentSession!.date = Date()
        Log.logger.info("I: [LogDatabase][startSession] session started")
        
        saveContext()
    }
    
    public func saveLog(_ log: Log) {
        guard let viewContext, let currentSession else {
            Log.logger.warning("D: [LogDatabase][saveLog] tried to save log, but session isn't started")
            return
        }
        
        let log = log.toLogDB(context: viewContext)
        currentSession.addToLogs(log)
        
        saveContext()
    }
    
    public func saveLogs(_ logs: [Log]) {
        guard let viewContext, let currentSession else {
            Log.logger.warning("D: [LogDatabase][saveLog] tried to save logs, but session isn't started")
            return
        }
        
        let logs = logs.toLogsDB(context: viewContext)
        logs.forEach(currentSession.addToLogs)
        
        saveContext()
    }
    
    public func fetchLogs() -> [LogDB] {
        guard let viewContext else {
            return []
        }
        
        let request = LogDB.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let items = try viewContext.fetch(request)
            return items
        } catch {
            Log.logger.error("E: [LogDatabase][fetchLogs] \(error)")
            return []
        }
    }
    
    public func fetchSessions() -> [SessionDB] {
        guard let viewContext else {
            return []
        }
        
        let request = SessionDB.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let items = try viewContext.fetch(request)
            return items
        } catch {
            Log.logger.error("E: [LogDatabase][fetchSessions] \(error)")
            return []
        }
    }

    private func saveContext() {
        guard let viewContext, viewContext.hasChanges else {
            return
        }
        
        do {
            try viewContext.save()
        } catch {
            Log.logger.error("E: [LogDatabase][saveContext] \(error)")
        }
    }
}
