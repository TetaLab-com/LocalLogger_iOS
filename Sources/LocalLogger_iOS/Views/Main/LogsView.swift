//
//  LogsView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct LogsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var viewModel: LogsViewModel
    
    var body: some View {
        VStack {
            header
            searchBar
            logsSection
        }
        .background(colorScheme == .light ? Color.purpleBackground : Color.emptyBackgroundDark)
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private var header: some View {
        MainHeaderView(
            titleText: "Logs",
            showTrailingItems: true,
            level: $viewModel.selectedLevel,
            shareItem: viewModel.filteredLogs.getShareString()
        )
    }
    
    private var searchBar: some View {
        MainSearchBarView(searchText: $viewModel.searchText)
            .padding(.horizontal)
    }
    
    private var logsSection: some View {
        LogsSectionView(logs: viewModel.filteredLogs)
    }
}

#Preview {
    LogsView()
        .environmentObject(LogsViewModel())
}
