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
                level: $viewModel.selectedLevel
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
        ScrollView {
            LazyVStack(spacing: 0) {
                let logs = viewModel.filteredLogs.enumeratedArray()
                
                ForEach(logs, id: \.element.dateTime) { index, log in
                    LogCellView(log: log, index: index)
                }
            }
        }
    }
}

#Preview {
    LogsView()
        .environmentObject(LogsViewModel())
}
