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
            MainHeaderView(titleText: "Logs", showTrailingItems: true)
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
            VStack(spacing: 0) {
                ForEach(viewModel.filteredLogs.indices, id: \.self) { index in
                    logItemView(index: index)
                }
            }
        }
    }
    
    @ViewBuilder
    private func logItemView(index: Int) -> some View {
        let log = viewModel.filteredLogs[index]
        HStack {
            Text(log.dateTime.toString())
                .foregroundStyle(colorScheme == .light ? Color.textGray : Color.white)
            
            Spacer()
            
            Text(log.level.getLevelPrefix() + log.message)
                .foregroundStyle(log.level.getColor())
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .padding(.horizontal, 20)
        .background(index % 2 == 1 ? Color.purpleBackground : Color.purpleSecondary)
        .font(.roboto400, size: 20)
    }
}

#Preview {
    LogsView()
        .environmentObject(LogsViewModel())
}
