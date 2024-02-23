//
//  SessionLogsView.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import SwiftUI

struct SessionLogsView: View {
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
        .padding(.top, -ScreenUtils.statusBarHeight)
        .safeAreaInset(edge: .bottom) {
            Frame(height: 60)
        }
    }
    
    private var header: some View {
        MainHeaderView(
            titleText: viewModel.navigationTitle,
            showTrailingItems: true,
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
