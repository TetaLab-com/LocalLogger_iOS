//
//  MainHeaderView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct MainHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    let titleText: String
    let showTrailingItems: Bool
    var showBackButton: Bool = false
    var level: Binding<Level?>? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            backButton
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
    
    @ViewBuilder
    private var backButton: some View {
        if showBackButton {
            BackButton(action: dismiss.callAsFunction)
                .foregroundStyle(Color.white)
        }
    }
    
    private var title: some View {
        Text(titleText)
            .foregroundStyle(Color.white)
            .font(.roboto700, size: 22)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var levelPicker: some View {
        Menu {
            Button {
                level?.wrappedValue = nil
            } label: {
                Label("All", systemImage: level?.wrappedValue == nil ? "checkmark" : "")
            }
            
            Divider()

            ForEach(Level.allCases, id: \.self) { level in
                Button {
                    self.level?.wrappedValue = level
                } label: {
                    Label(
                        level.rawValue,
                        systemImage: self.level?.wrappedValue == level ? "checkmark" : ""
                    )
                }
            }
        } label: {
            HStack {
                Text(level?.wrappedValue?.rawValue ?? "All")
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
        MainHeaderView(
            titleText: "Logs",
            showTrailingItems: true,
            level: .constant(.INFO)
        )
        Spacer()
    }
    .ignoresSafeArea(.container, edges: .top)
    .environmentObject(LogsViewModel())
}
