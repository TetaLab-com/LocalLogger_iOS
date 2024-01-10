//
//  LocalLoggerApp.swift
//  LocalLogger
//
//  Created by Taras Teslyuk
//

import SwiftUI

@main
struct LocalLoggerApp: App {
    @StateObject var navigationManager = NavigationManager()
    @StateObject var viewModel = LogsViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .environmentObject(navigationManager)
        .environmentObject(viewModel)
    }
}
