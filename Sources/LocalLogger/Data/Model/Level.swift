//
//  Level.swift
//  LocalLogger
//
//  Created by Taras Teslyuk
//

import Foundation
import SwiftUI

enum Level: String, CaseIterable, Codable, Hashable {
    case info = "Info"
    case warning = "Warning"
    case error = "Error"
    case inMessage = "IN"//used for messages received at Mobile phone
    case outMessage = "OUT"//used for messages sent from Mobile phone

    var levelPrefix: String {
        switch self {
        case .info: return "I: "
        case .warning: return "D: "
        case .error: return "E: "
        case .inMessage: return "<--: "
        case .outMessage: return "-->: "
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .info: return .infoMessage
        case .warning: return .warningMessage
        case .error: return .errorMessage
        case .inMessage: return .inMessage
        case .outMessage: return .outMessage
        }        
    }
}
