//
//  SessionLogsViewModel.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import Foundation
import Combine

class SessionLogsViewModel: ObservableObject {
    @Published public var searchText = ""
    @Published public var selectedLevel: Level?
    
    @Published private(set) var navigationTitle = ""
    
    @Published private(set) var logs = [Log]()
    @Published private(set) var filteredLogs = [Log]()
    
    @Published private(set) var session: Session
    @Published private(set) var sessionDB: SessionDB
    
    private var cancellables = Set<AnyCancellable>()
    
    init(sessionDB: SessionDB) {
        self.sessionDB = sessionDB
        self.session = sessionDB.toSession()
        self.logs = sessionDB
            .getLogs()
            .toLogs()
        self.filteredLogs = self.logs
        
        self.navigationTitle = session.date.sessionDateFormat()
        
        setupFilters()
        setupLogs()
    }
    
    private func setupFilters() {
        let textPublisher = $searchText
            .debounce(for: 0.15, scheduler: RunLoop.main)
            .removeDuplicates()
        
        let selectedLevelPublisher = $selectedLevel.removeDuplicates()
        
        let logsPublisher = $logs.removeDuplicates()
        
        Publishers.CombineLatest3(textPublisher, selectedLevelPublisher, logsPublisher)
            .sink { [weak self] searchText, level, logs in
                guard let self else { return }
                
                self.filteredLogs = logs.filter(
                    level: level,
                    searchText: searchText
                )
            }
            .store(in: &cancellables)
    }
    
    private func setupLogs() {
        sessionDB.observeLogs { [weak self] logs in
            guard let self else { return }
            
            self.logs = logs.toLogs()
        }
    }
}
