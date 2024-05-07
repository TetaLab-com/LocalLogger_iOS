//
//  SessionLogsView.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import SwiftUI

struct SessionLogsView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @StateObject private var viewModel: SessionLogsViewModel
    
    init(sessionDB: SessionDB) {
        _viewModel = .init(wrappedValue: .init(sessionDB: sessionDB))
    }
    
    var body: some View {
        VStack {
            header
            searchBar
            logs
        }
        .background(colorScheme == .light ? Color.purpleBackground : Color.emptyBackgroundDark)
        .safeAreaInset(edge: .bottom) {
            Frame(height: 60)
        }
    }
    
    private var header: some View {
        MainHeaderView(
            titleText: viewModel.navigationTitle,
            showTrailingItems: true,
            isClose: false,
            showBackButton: true,
            level: $viewModel.selectedLevel,
            shareItem: viewModel.filteredLogs.getShareString()
        )
    }
    
    private var searchBar: some View {
        MainSearchBarView(searchText: $viewModel.searchText)
            .padding(.horizontal)
    }
    
    private var logs: some View {
        LogsSectionView(logs: viewModel.filteredLogs)
    }
}
