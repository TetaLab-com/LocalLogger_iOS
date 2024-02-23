//
//  CustomFont.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import Foundation
import SwiftUI

enum CustomFont: String, CaseIterable, Identifiable, Equatable {
    var id: RawValue { rawValue }
    
    case roboto100, roboto300, roboto400, roboto500, roboto700, roboto900
    
    internal func font(_ size: CGFloat) -> Font {
        switch self {
        case .roboto100: return .custom("Roboto-Thin", fixedSize: size)
        case .roboto300: return .custom("Roboto-Light", fixedSize: size)
        case .roboto400: return .custom("Roboto-Regular", fixedSize: size)
        case .roboto500: return .custom("Roboto-Medium", fixedSize: size)
        case .roboto700: return .custom("Roboto-Bold", fixedSize: size)
        case .roboto900: return .custom("Roboto-Black", fixedSize: size)
        }
    }
}

extension Text {
    func font(_ customFont: CustomFont, size: CGFloat) -> Text {
        font(customFont.font(size))
    }
}

extension View {
    func font(_ customFont: CustomFont, size: CGFloat) -> some View {
        font(customFont.font(size))
    }
}

#Preview {
    VStack(spacing: 8) {
        ForEach(CustomFont.allCases) { font in
            Text("Some text example")
                .font(font, size: 22)
        }
    }
}
