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
    
    public func appendHistoryPath<T: Hashable>(_ path: T) {
        historyPath.append(path)
    }
    
    public func clearHistoryPath() {
        historyPath = NavigationPath()
    }
}

struct SessionLogsPath: Codable, Hashable {
    let session: Session
}

extension View {
    func addNavigationPaths() -> some View { self
        .navigationDestination(for: SessionLogsPath.self) { session in
            SessionLogsView(session: session.session)
                .toolbar(.hidden)
        }
    }
}
