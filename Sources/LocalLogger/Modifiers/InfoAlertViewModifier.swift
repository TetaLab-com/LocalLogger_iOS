//
//  AlertViewModifier.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct InformationAlertView: ViewModifier {
    @Binding public var showAlert: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(contentOverlay)
            .padding(showAlert ? -2 : 0)
            .blur(radius: showAlert ? 1 : 0)
            .overlay(alert)
            .animation(.spring(), value: showAlert)
    }
    
    @ViewBuilder
    private var contentOverlay: some View {
        if showAlert {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    private var alert: some View {
        if showAlert {
            InformationView(showAlert: $showAlert)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .transition(.opacity.combined(with: .scale(scale: 0.5)))
                .padding(.horizontal)
        }
    }
}

