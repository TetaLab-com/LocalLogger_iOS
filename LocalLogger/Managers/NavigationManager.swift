//
//  NavigationManager.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import Foundation

final class NavigationManager: ObservableObject {
    @Published var tabBarSize = CGSize()
    
    @Published var selectedTab: TabItem = .home
    @Published var previouslySelectedTab: TabItem = .home
}
