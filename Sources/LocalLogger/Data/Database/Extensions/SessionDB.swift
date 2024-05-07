//
//  SessionDB.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import Foundation
import CoreData

extension Array where Element == SessionDB {
    func toSessions() -> [Session] {
        map { $0.toSession() }
    }
}

extension SessionDB {
    static var logsObserver = [SessionDB: NSKeyValueObservation]()
    
    func toSession() -> Session {
        Session(
            date: date ?? Date(),
            logs: getLogs().toLogs()
        )
    }
    
    func getLogs() -> [LogDB] {
        let logs = logs ?? []
        
        return logs.toArray(LogDB.self)
    }
    
    func observeLogs(onUpdate: @escaping ([LogDB]) -> ()) {
        Self.logsObserver[self] = observe(\.logs) { session, _ in
            onUpdate(session.getLogs())
        }
    }
}

extension NSOrderedSet {
    func toArray<T>(_ type: T.Type) -> [T] {
        compactMap { $0 as? T }
    }
}
