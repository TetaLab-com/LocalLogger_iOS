//
//  LogDataSource.swift
//  LocalLogger
//
//  Created by Taras Teslyuk
//

import Foundation
import SwiftUI

class LogDataSource : ObservableObject {
    static let shared = LogDataSource()
    
    @Published private(set) var logs = [Log]()
    
    private func addLog(_ log: Log) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            self.logs.append(log)
            LogDatabase.shared.saveLog(log)
            print("Log", "[\(log.className)] [\(log.methodName)] \(log.message)")
        }
    }

    func w(className: String, methodName: String, message: String) {
       addLog(Log(dateTime: getDate(),
                  message: message,
                  level: .warning,
                  className: className,
                  methodName: methodName))
    }

    func w(_ message: String) {
        w(className: "", methodName: "", message: message)
    }

    func i(className: String, methodName: String, message: String) {
        addLog(Log(dateTime: getDate(),
                   message: message,
                   level: .info,
                   className: className,
                   methodName: methodName))
    }

    func i(_ message: String) {
        i(className: "", methodName: "", message: message)
    }
    
    func e(className: String, methodName: String, message: String) {
        addLog(Log(dateTime: getDate(),
                   message: message,
                   level: .error,
                   className: className,
                   methodName: methodName))
    }

    func e(_ message: String) {
        e(className: "", methodName: "", message: message)
    }
    
    func inMessage(className: String, methodName: String, message: String) {
        addLog(Log(dateTime: getDate(),
                   message: message,
                   level: .inMessage,
                   className: className,
                   methodName: methodName))
    }

    func inMessage(_ message: String) {
        inMessage(className: "", methodName: "", message: message)
    }
    
    func outMessage(className: String, methodName: String, message: String) {
        addLog(Log(dateTime: getDate(),
                   message: message,
                   level: .outMessage,
                   className: className,
                   methodName: methodName))
    }

    func outMessage(_ message: String) {
        outMessage(className: "", methodName: "", message: message)
    }
    
    public func getDate() -> Date {
        return Date()
    }
    
}
