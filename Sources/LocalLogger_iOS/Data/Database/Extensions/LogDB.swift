//
//  LogDB.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import Foundation
import CoreData

extension Sequence where Element == Log {
    @discardableResult
    func toLogsDB(context: NSManagedObjectContext) -> [LogDB] {
        map { $0.toLogDB(context: context) }
    }
}

extension Log {
    @discardableResult
    func toLogDB(context: NSManagedObjectContext) -> LogDB {
        LogDB(
            context: context,
            log: self
        )
    }
}

extension Sequence where Element == LogDB {
    func toLogs() -> [Log] {
        compactMap { $0.toLog() }
    }
}

extension LogDB {
    convenience init(context: NSManagedObjectContext, log: Log) {
        let entity = NSEntityDescription.entity(forEntityName: "LogDB", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.date = log.dateTime
        self.level = log.level.rawValue
        self.logClassName = log.className
        self.logMethodName = log.methodName
        self.message = log.message
    }
    
    @discardableResult
    func toLog() -> Log? {
        guard
            let date,
            let message,
            let level,
            let logClassName,
            let logMethodName
        else {
            return nil
        }
        
        return Log(
            dateTime: date,
            message: message,
            level: Level(rawValue: level) ?? .info,
            className: logClassName,
            methodName: logMethodName
        )
    }
}
