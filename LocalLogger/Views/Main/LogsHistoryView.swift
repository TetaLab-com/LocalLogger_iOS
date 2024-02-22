//
//  LogsHistoryView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct LogsHistoryView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var viewModel: LogsViewModel
    @EnvironmentObject var navigation: NavigationManager
    
    var body: some View {
        VStack(spacing: 0) {
            MainHeaderView(
                titleText: "Logs History",
                showTrailingItems: false
            )
            
            logsSection
        }
        .background(colorScheme == .light ? Color.purpleBackground : Color.emptyBackgroundDark)
        .ignoresSafeArea(.container, edges: .top)
        .safeAreaInset(edge: .bottom) {
            Frame(height: 60)
        }
    }
    
    private var logsSection: some View {
        ScrollView {
            VStack(spacing: 0) {
                let sessions = viewModel.sessions.enumeratedArray()
                ForEach(sessions, id: \.element.id) { index, session in
                    Button {
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

extension Sequence {
    func enumeratedArray() -> [(offset: Int, element: Element)] {
        Array(self.enumerated())
    }
}
