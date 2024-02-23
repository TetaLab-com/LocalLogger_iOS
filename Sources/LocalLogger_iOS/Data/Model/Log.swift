//
//  Log.swift
//  LocalLogger
//
//  Created by Taras Teslyuk
//

import Foundation
import os

struct Log: Hashable, Codable {
    static internal let logger = Logger(
        subsystem: Bundle.module.bundleIdentifier!,
        category: "LocalLoggerIOS"
    )
    
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

    func getUserMessage(prefix: Bool = true) -> String {
        var finalMessage = prefix ? "\(level.levelPrefix)" : ""
        
        if let className = prepareClassName() {
            finalMessage += "[\(className)]"
        }
        
        if let methodName = prepareMethodName() {
            finalMessage += "[\(methodName)]"
        }
        
        return finalMessage + " \(message)"
    }

    func toString() -> String {
        return "\(dateTime) \(level.levelPrefix) \(getUserMessage())"
    }
    
    func searchableText() -> String {
        dateTime.logDateFormat() + level.levelPrefix + message
    }
    
    func printLog() {
        let message = getUserMessage(prefix: true)
        
        switch level {
        case .info: Self.logger.info("\(message)")
        case .warning: Self.logger.warning("\(message)")
        case .error: Self.logger.critical("\(message)")
        case .inMessage: Self.logger.info("\(message)")
        case .outMessage: Self.logger.info("\(message)")
        }
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
        let log = level.levelPrefix + message
        
        return date + " " + log
    }
}
