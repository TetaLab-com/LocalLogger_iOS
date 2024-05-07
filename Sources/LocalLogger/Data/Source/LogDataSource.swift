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
            log.printLog()
        }
    }

    internal func w(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
       addLog(Log(dateTime: getDate(),
                  message: message,
                  level: .warning,
                  className: className,
                  methodName: methodName))
    }

    internal func i(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        addLog(Log(dateTime: getDate(),
                   message: message,
                   level: .info,
                   className: className,
                   methodName: methodName))
    }
    
    internal func e(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        addLog(Log(dateTime: getDate(),
                   message: message,
                   level: .error,
                   className: className,
                   methodName: methodName))
    }
    
    internal func inMessage(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        addLog(Log(dateTime: getDate(),
                   message: message,
                   level: .inMessage,
                   className: className,
                   methodName: methodName))
    }
    
    internal func outMessage(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        addLog(Log(dateTime: getDate(),
                   message: message,
                   level: .outMessage,
                   className: className,
                   methodName: methodName))
    }
    
    private func getDate() -> Date {
        return Date()
    }
}
