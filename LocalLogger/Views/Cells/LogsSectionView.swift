//
//  LogsSectionView.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import SwiftUI

struct LogsSectionView: View {
    let logs: [Log]
    
    @State private var lastVisibleIndex = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0) {
                    let logs = logs.enumeratedArray()
                    
                    ForEach(logs, id: \.element.dateTime) { index, log in
                        LogCellView(log: log, index: index)
                            .onAppear { lastVisibleIndex = index }
                            .id(log.dateTime)
                    }
                }
            }
            .onAppear {
                proxy.scrollTo(
                    logs.last?.dateTime,
                    anchor: .top
                )
            }
            .onChange(of: logs.count) { count in
                if lastVisibleIndex + 10 >= count {
                    proxy.scrollTo(
                        logs.last?.dateTime,
                        anchor: .top
                    )
                }
            }
        }
    }
}

extension Sequence {
    func enumeratedArray() -> [(offset: Int, element: Element)] {
        Array(self.enumerated())
    }
}

#Preview {
    LogsSectionView(logs: [])
}
