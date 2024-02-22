//
//  Log.swift
//  LocalLogger
//
//  Created by Taras Teslyuk
//

import Foundation

struct Log: Hashable, Codable {
    var dateTime: Date
    var message: String
    var level: Level = .warning
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
        dateTime.logDateFormat() + level.getLevelPrefix() + message
    }
}

extension Array where Element == Log {
    func getShareString() -> String { self
        .map { $0.getShareString() }
        .joined(separator: "\n")
    }
    
    func filter(level: Level?, searchText: String) -> [Log] {
        if level == nil && searchText.isEmpty {
            return self
        }
        
        return filter { log in
            let logSearchable = log.searchableText()
            
            // Фільтрація за текстом пошуку та вибраним рівнем
            let searchTextCondition = searchText.isEmpty || logSearchable.contains(searchText)
            let selectedLevelCondition = level == nil || log.level == level

            return searchTextCondition && selectedLevelCondition
        }
    }
}

extension Log {
    func getShareString() -> String {
        let date = dateTime.logDateFormat()
        let log = level.getLevelPrefix() + message
        
        return date + " " + log
    }
}
