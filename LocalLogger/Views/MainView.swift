//
//  MainView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var viewModel: LogsViewModel
    
    @State var showInfoAlert = false
    
    var body: some View {
        VStack {
            switch navigationManager.selectedTab {
            case .home:
                LogsView()
            case .history:
                NavigationStack(path: $navigationManager.historyPath) {
                    LogsHistoryView().addNavigationPaths()
                }
            case .info:
                previouslySelectedView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            MainTabBarView()
        }
        .ignoresSafeArea(.keyboard)
        .onChange(of: navigationManager.selectedTab) {
            guard navigationManager.selectedTab != .info else { return }
            navigationManager.previouslySelectedTab = navigationManager.selectedTab
        }
        .informationAlert($showInfoAlert)
    }
    
    @ViewBuilder
    private var previouslySelectedView: some View {
        VStack {
            switch navigationManager.previouslySelectedTab {
            case .home:
                LogsView()
            case .history:
                LogsHistoryView()
            case .info:
                EmptyView()
            }
        }
        .onAppear {
            showInfoAlert = true
        }
    }
}

#Preview {
    MainView()
        .environmentObject(NavigationManager())
        .environmentObject(LogsViewModel())
}
