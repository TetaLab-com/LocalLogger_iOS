//
//  LogsViewModel.swift
//  LocalLogger
//
//  Created by Taras Teslyuk
//

import Foundation
import SwiftUI

class LogsViewModel : ObservableObject {
    @Published var logs = [Log]()
    @Published var sessions = [SessionDB]()
    
    @Published var searchText = ""
    
    @Published var selectedLevel: Level?

    var filteredLogs: [Log] {
        logs.filter(
            level: selectedLevel,
            searchText: searchText
        )
    }
    
    public let logsManager = LogDataSource.shared
    
    init() {
        logsManager.$logs
            .assign(to: &$logs)
        
        sessions = LogDBManager.shared.fetchSessions()
    }
    
    public func copy() {
        UIPasteboard.general.string = logsManager.logs
            .map { $0.getUserMessage().trimmingCharacters(in: .whitespacesAndNewlines) }
            .joined(separator: "\n")
    }
    
    public func getLogs() -> [Log] {
        return logs
    }
}

