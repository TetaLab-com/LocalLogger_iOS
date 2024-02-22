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
    let dateFormatter = DateFormatter()
    
    @Published public var logs = [Log]()
    
    init () {
        dateFormatter.dateFormat = "mm:ss.SSSS"
        dateFormatter.locale = Locale(identifier: "en_US")
        
        w("message1")
        i("message2")
        e("message3")
        inMessage("message4")
        outMessage("message5")
    }
    
    private func addLog(_ log: Log) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.logs.append(log)
            LogDBManager.shared.saveLog(log)
            print("Log", "[\(log.className)] [\(log.methodName)] \(log.message)")
            //        notifyListUpdates()
        }
    }

    func w(className: String, methodName: String, message: String) {
       addLog(Log(dateTime: getTimeString(),
                  message: message,
                  level: Level.WARNING,
                  className: className,
                  methodName: methodName))
    }

    func w(_ message: String) {
        w(className: "", methodName: "", message: message)
    }

    func i(className: String, methodName: String, message: String) {
        addLog(Log(dateTime: getTimeString(),
                   message: message,
                   level: Level.INFO,
                   className: className,
                   methodName: methodName))
    }

    func i(_ message: String) {
        i(className: "", methodName: "", message: message)
    }
    
    func e(className: String, methodName: String, message: String) {
        addLog(Log(dateTime: getTimeString(),
                   message: message,
                   level: Level.ERROR,
                   className: className,
                   methodName: methodName))
    }

    func e(_ message: String) {
        e(className: "", methodName: "", message: message)
    }
    
    func inMessage(className: String, methodName: String, message: String) {
        addLog(Log(dateTime: getTimeString(),
                   message: message,
                   level: Level.IN_MESSAGE,
                   className: className,
                   methodName: methodName))
    }

    func inMessage(_ message: String) {
        inMessage(className: "", methodName: "", message: message)
    }
    
    func outMessage(className: String, methodName: String, message: String) {
        addLog(Log(dateTime: getTimeString(),
                   message: message,
                   level: Level.OUT_MESSAGE,
                   className: className,
                   methodName: methodName))
    }

    func outMessage(_ message: String) {
        outMessage(className: "", methodName: "", message: message)
    }
    
    public func getTimeString() -> Date {
        let date = Date()
//        return dateFormatter.string(from: date)
        return date
    }
    
}
