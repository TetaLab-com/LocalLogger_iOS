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
        var finalMessage = "\(level.rawValue):"
        
        if let className = prepareClassName() {
            finalMessage += "[\(className)]"
        }
        
        if let methodName = prepareMethodName() {
            finalMessage += "[\(methodName)]"
        }
        
        return finalMessage + " \(message)"
    }

    func toString() -> String {
        return "\(dateTime) \(level.getLevelPrefix()) \(getUserMessage())"
    }
    
    func searchableText() -> String {
        dateTime.logDateFormat() + level.getLevelPrefix() + message
    }
    
    private func prepareMethodName() -> String? {
        if methodName.isEmpty {
            return nil
        }
        
        let preparedName = methodName
            .components(separatedBy: "(")
            .first
        
        return preparedName
    }
    
    private func prepareClassName() -> String? {
        if className.isEmpty {
            return nil
        }
        
        let preparedName = className
            .components(separatedBy: "/")
            .last?
            .replacingOccurrences(of: ".swift", with: "")
        
        return preparedName
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
