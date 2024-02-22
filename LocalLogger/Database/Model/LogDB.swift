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
    func toLogsDB() -> [LogDB] {
        map { $0.toLogDB() }
    }
}

extension Log {
    @discardableResult
    func toLogDB() -> LogDB {
        LogDB(
            context: LogDBManager.shared.viewContext,
            log: self
        )
    }
}

extension Sequence where Element == LogDB {
    func toLogs() -> [Log] {
        map { $0.toLog() }
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
    func toLog() -> Log {
        Log(
            dateTime: date!,
            message: message!,
            level: Level(rawValue: level!)!,
            className: logClassName!,
            methodName: logMethodName!
        )
    }
}
