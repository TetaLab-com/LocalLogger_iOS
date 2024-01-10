//
//  MainTabBarView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

enum TabItem: Int, CaseIterable, Identifiable, Equatable {
    var id: RawValue { rawValue }
    
    case home, history, info
    
    var image: String {
        switch self {
        case .home: return "homeIcon"
        case .history: return "historyIcon"
        case .info: return "infoIcon"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .history: return "History"
        case .info: return "Information"
        }
    }
}

struct TabBarItemView: View {
    let tabItem: TabItem
    let isSelected: Bool
    var action: (TabItem) -> ()
    
    var body: some View {
        Button {
            action(tabItem)
        } label: {
            VStack(spacing: 4) {
                Image(tabItem.image)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(isSelected ? Color.purpleButton : Color.purpleGray)
                    .frame(width: 18, height: 18)
                
                Text(tabItem.title)
                    .font(.roboto500, size: 12)
                    .foregroundColor(isSelected ? Color.purpleMain : Color.purpleGray)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct MainTabBarView: View {
    @EnvironmentObject var navigationManager: NavigationManager
        
    var body: some View {
        HStack {
            ForEach(TabItem.allCases) { tab in
                let isSelected = tab == navigationManager.selectedTab
                
                TabBarItemView(
                    tabItem: tab,
                    isSelected: isSelected,
                    action: tabTapAction
                )
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .background {
            Rectangle()
                .foregroundStyle(Color.purpleBackground)
                .ignoresSafeArea()
                .shadow(color: Color.black.opacity(0.06), radius: 30, x: 0, y: -12)
        }
        .readSize { navigationManager.tabBarSize = $0 }
    }
    
    private func tabTapAction(_ tab: TabItem) {
        navigationManager.selectedTab = tab
    }
}

#Preview {
    VStack(spacing: 0) {
        Color.purpleMain
        MainTabBarView()
        
    }
    .environmentObject(NavigationManager())
}
