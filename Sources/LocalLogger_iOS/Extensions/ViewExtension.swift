//
//  ViewExtension.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
    
    func informationAlert(_ show: Binding<Bool>) -> some View {
        modifier(
            InformationAlertView(showAlert: show)
        )
    }
}


struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


struct TabBarSafeArea: ViewModifier {
    @EnvironmentObject private var navigationManager: NavigationManager
    
    func body(content: Content) -> some View {
        content.safeAreaInset(edge: .bottom) {
            Color.clear
                .frame(height: navigationManager.tabBarSize.height + 16)
        }
    }
}
