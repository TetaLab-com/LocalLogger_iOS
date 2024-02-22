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
    func toSession() -> Session {
        Session(
            date: date ?? Date(),
            logs: logs?.toArray(LogDB.self).toLogs() ?? []
        )
    }
}

extension NSSet {
    func toArray<T>(_ type: T.Type) -> [T] {
        map { $0 as! T }
    }
}
