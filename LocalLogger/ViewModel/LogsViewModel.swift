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
    @Published var sessions = [Session]()
    
    @Published var searchText = ""
    
    @Published var selectedLevel: Level?

    var filteredLogs: [Log] {
        if searchText.isEmpty && selectedLevel == nil {
            // Якщо searchText порожній і вибраний рівень null, повертаємо усі логи
            return logs
        } else {
            return logs.filter { log in
                let logSearchable = log.dateTime.toString() + "" + log.level.getLevelPrefix() + log.message
                
                // Фільтрація за текстом пошуку та вибраним рівнем
                let searchTextCondition = searchText.isEmpty || logSearchable.contains(searchText)
                let selectedLevelCondition = selectedLevel == nil || log.level == selectedLevel

                return searchTextCondition && selectedLevelCondition
            }
        }
    }
    
    public let logsManager = LogDataSource.shared
    
    init() {
        logsManager.$logs
            .assign(to: &$logs)
        
        sessions = LogDBManager.shared
            .fetchSessions()
            .toSessions()
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

