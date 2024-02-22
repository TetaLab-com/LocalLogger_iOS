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
    }
    
    private var logsSection: some View {
        ScrollView {
            VStack(spacing: 0) {
                let sessions = viewModel.sessions.enumeratedArray()
                ForEach(sessions, id: \.element.date) { offset, session in
                    HStack(spacing: 28) {
                        Text(session.date.sessionDateFormat())
                            .foregroundStyle(Color.primary)
                        
                        Spacer()
                        
                        ShareLink(item: "shared log info") {
                            Image("shareIcon")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(Color.purpleMain)
                                .frame(width: 24, height: 24)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background(offset % 2 == 0 ? Color.purpleBackground : Color.purpleSecondary)
                    .font(.roboto400, size: 20)
                }
            }
        }
    }
    
    @ViewBuilder
    private func logItemView(index: Int) -> some View {
        let log = viewModel.logs[index]
        HStack(spacing: 28) {
            Text(log.dateTime.toStringDate())
                .foregroundStyle(Color.primary)
                        
            Text(log.dateTime.toStringTime())
                .foregroundStyle(Color.primary)
            
            Spacer()
            
            ShareLink(item: "shared log info") {
                Image("shareIcon")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.purpleMain)
                    .frame(width: 24, height: 24)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .padding(.horizontal, 20)
        .background(index % 2 == 0 ? Color.purpleBackground : Color.purpleSecondary)
        .font(.roboto400, size: 20)
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
