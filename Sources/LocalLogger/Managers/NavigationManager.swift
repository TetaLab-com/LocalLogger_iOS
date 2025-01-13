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
    
    @Published var showingInfoAlert = false
    @Published var selectedTab: TabItem = .home
    @Published var previouslySelectedTab: TabItem = .home
    
    @available(iOS 16.0, *)
    @Published var historyPath = NavigationPath()
    
    @available(iOS 16.0, *)
    public var showingTabbar: Bool { historyPath.isEmpty }
    
    @available(iOS 16.0, *)
    public func appendHistoryPath<T: Hashable>(_ path: T) {
        historyPath.append(path)
    }
    
    @available(iOS 16.0, *)
    public func clearHistoryPath() {
        historyPath = NavigationPath()
    }
}

struct SessionLogsPath: Hashable {
    let session: SessionDB
}

extension View {
    @ViewBuilder
    func addNavigationPaths() -> some View { self
        if #available(iOS 16.0, *) {
            self.navigationDestination(for: SessionLogsPath.self) { session in
                SessionLogsView(sessionDB: session.session)
                    .toolbar(.hidden)
            }
        } else {
            self
        }
    }
}
