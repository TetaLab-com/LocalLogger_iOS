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
    
    init() {
        //LogDatabase.shared.resetDB()
        LogDatabase.shared.startSession()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(navigationManager)
                .environmentObject(viewModel)
        }
    }
}
