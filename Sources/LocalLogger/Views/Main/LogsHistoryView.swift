//
//  LogsHistoryView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct LogsHistoryView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @EnvironmentObject private var viewModel: LogsViewModel
    @EnvironmentObject private var navigation: NavigationManager
    
    var body: some View {
        NavigationStack(path: $navigation.historyPath) {
            VStack(spacing: 0) {
                header
                logsSection
            }
            .background(colorScheme == .light ? Color.purpleBackground : Color.emptyBackgroundDark)
            .ignoresSafeArea(.container, edges: .top)
            .safeAreaInset(edge: .bottom) {
                Frame(height: 60)
            }
            .addNavigationPaths()
        }
    }
    
    private var header: some View {
        MainHeaderView(
            titleText: "Logs History",
            showTrailingItems: false,
            shareItem: nil
        )
    }
    
    private var logsSection: some View {
        ScrollView {
            VStack(spacing: 0) {
                let sessions = viewModel.sessions.enumeratedArray()
                
                ForEach(sessions, id: \.element.id) { index, session in
                    Button {
                        viewModel.updateSessions()
                        navigation.appendHistoryPath(SessionLogsPath(session: session))
                    } label: {
                        SessionCellView(
                            session: session.toSession(),
                            index: index
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    LogsHistoryView()
        .environmentObject(LogsViewModel())
}
