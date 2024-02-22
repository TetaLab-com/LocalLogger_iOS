//
//  NavigationManager.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import Foundation
import SwiftUI

final class NavigationManager: ObservableObject {
    @Published var tabBarSize = CGSize()
    
    @Published var selectedTab: TabItem = .home
    @Published var previouslySelectedTab: TabItem = .home
    
    @Published var historyPath = NavigationPath()
    
    public var showingTabbar: Bool { historyPath.isEmpty }
    
    public func appendHistoryPath<T: Hashable>(_ path: T) {
        historyPath.append(path)
    }
    
    public func clearHistoryPath() {
        historyPath = NavigationPath()
    }
}

struct SessionLogsPath: Hashable {
    let session: SessionDB
}

extension View {
    func addNavigationPaths() -> some View { self
        .navigationDestination(for: SessionLogsPath.self) { session in
            SessionLogsView(sessionDB: session.session)
                .toolbar(.hidden)
        }
    }
}
