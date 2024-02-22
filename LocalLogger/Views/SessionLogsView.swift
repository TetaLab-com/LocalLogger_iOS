//
//  SessionLogsView.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import SwiftUI

struct SessionLogsView: View {
    @StateObject private var viewModel: SessionLogsViewModel
    
    init(session: Session) {
        _viewModel = .init(wrappedValue: .init(session: session))
    }
    
    var body: some View {
        VStack {
            header
            searchBar
            logs
        }
        .padding(.top, -ScreenUtils.statusBarHeight)
    }
    
    private var header: some View {
        MainHeaderView(
            titleText: viewModel.navigationTitle,
            showTrailingItems: true,
            showBackButton: true,
            level: $viewModel.selectedLevel
        )
    }
    
    private var searchBar: some View {
        MainSearchBarView(searchText: $viewModel.searchText)
            .padding(.horizontal)
    }
    
    private var logs: some View {
        ScrollView {
            let logs = viewModel.filteredLogs.enumeratedArray()
            LazyVStack(spacing: 0) {
                ForEach(logs, id: \.element.dateTime) { index, log in
                    LogCellView(log: log, index: index)
                }
            }
        }
    }
}

#Preview {
    SessionLogsView(session: .init(date: Date(), logs: []))
}
