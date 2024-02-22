//
//  Log.swift
//  LocalLogger
//
//  Created by Taras Teslyuk
//

import Foundation

struct Log: Hashable {
    
    static func == (lhs: Log, rhs: Log) -> Bool {
        return lhs.dateTime == rhs.dateTime
        && lhs.message == rhs.message
        && lhs.level == rhs.level
        && lhs.className == rhs.className
        && lhs.methodName == rhs.methodName
    }
    
    var dateTime: Date
    var message: String
    var level: Level = Level.WARNING
    var className: String = ""
    var methodName: String = ""
    
    init(dateTime: Date, message: String, level: Level, className: String, methodName: String) {
        self.dateTime = dateTime
        self.message = message
        self.level = level
        self.className = className
        self.methodName = methodName
    }

    func getUserMessage() -> String {
        if (!className.isEmpty) {
            if (!methodName.isEmpty) {
                return "[\(className)] [\(methodName)] \(message)"
            } else {
                return "[\(className)] \(message)"
            }
        } else {
            if (!methodName.isEmpty) {
                return "[\(methodName)] \(message)"
            } else {
                return message
            }
        }
    }

    func toString() -> String {
        return "\(dateTime) \(level.getLevelPrefix()) \(getUserMessage())"
    }
    
    func searchableText() -> String {
        dateTime.toString() + level.getLevelPrefix() + message
    }
}

extension Array where Element == Log {
    func filter(level: Level?, searchText: String) {
        
    }
}
