//
//  MainHeaderView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct MainHeaderView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var viewModel: LogsViewModel
    
    let titleText: String
    let showTrailingItems: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            title
            if showTrailingItems {
                levelPicker
                shareButton
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 20)
        .padding(.top, ScreenUtils.statusBarHeight)
        .background(colorScheme == .dark ? Color.mainBackgroundDark : Color.purpleMain)
        .frame(height: 120)
    }
    
    private var title: some View {
        Text(titleText)
            .foregroundStyle(Color.white)
            .font(.roboto700, size: 22)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var levelPicker: some View {
        Menu {
            Button(action: {
                viewModel.selectedLevel = nil
            }) {
                Label("All", systemImage: viewModel.selectedLevel == nil ? "checkmark" : "")
            }
            
            Divider()

            ForEach(Level.allCases, id: \.self) { level in
                Button(action: {
                    viewModel.selectedLevel = level
                }) {
                    Label(level.rawValue, systemImage: viewModel.selectedLevel == level ? "checkmark" : "")
                }
            }
        } label: {
            HStack {
                Text(viewModel.selectedLevel?.rawValue ?? "All")
                Image(systemName: "triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(180))
                    .frame(width: 10, height: 10)
            }
            .padding(.horizontal)
        }
        .font(.roboto400, size: 18)
        .foregroundStyle(Color.white)

    }
    
    private var shareButton: some View {
        ShareLink(item: "Share all logs") {
            Image("shareIcon")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color.white)
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    VStack {
        MainHeaderView(titleText: "Logs", showTrailingItems: true)
        Spacer()
    }
    .ignoresSafeArea(.container, edges: .top)
    .environmentObject(LogsViewModel())
}
