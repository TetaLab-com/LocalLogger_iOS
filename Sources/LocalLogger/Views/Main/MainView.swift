//
//  MainView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    var body: some View {
        VStack {
            switch navigationManager.selectedTab {
            case .home:
                LogsView()
            case .history:
                LogsHistoryView()
            case .info:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) { MainTabBarView() }
        .ignoresSafeArea(.keyboard)
        .informationAlert($navigationManager.showingInfoAlert)
    }
}

#Preview {
    MainView()
        .environmentObject(NavigationManager())
        .environmentObject(LogsViewModel())
}
