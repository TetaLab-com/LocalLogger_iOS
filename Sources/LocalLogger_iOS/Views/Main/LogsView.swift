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
        VStack(spacing: 0) {
            MainHeaderView(
                titleText: "Logs",
                showTrailingItems: true,
                level: $viewModel.selectedLevel,
                shareItem: viewModel.filteredLogs.getShareString()
            )
            MainSearchBarView(searchText: $viewModel.searchText)
                .padding()
            logsSection
            Spacer()
        }
        .background(colorScheme == .light ? Color.purpleBackground : Color.emptyBackgroundDark)
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private var logsSection: some View {
        LogsSectionView(logs: viewModel.filteredLogs)
    }
}

#Preview {
    LogsView()
        .environmentObject(LogsViewModel())
}
