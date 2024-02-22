//
//  Level.swift
//  LocalLogger
//
//  Created by Taras Teslyuk
//

import Foundation
import SwiftUI

enum Level: String, CaseIterable, Codable {
    case INFO = "Info"
    case WARNING = "Warning"
    case ERROR = "Error"
    case IN_MESSAGE = "IN"//used for messages received at Mobile phone
    case OUT_MESSAGE = "OUT"//used for messages sent from Mobile phone
    ;

    func getLevelPrefix() -> String {
        switch self {
        case .INFO: return "I: "
        case .WARNING: return "D: "
        case .ERROR: return "E: "
        case .IN_MESSAGE: return "<--: "
        case .OUT_MESSAGE: return "-->: "
        }
    }
    
    func getColor() -> Color {
        switch self {
        case .INFO: return Color.infoMessage
        case .WARNING: return Color.warningMessage
        case .ERROR: return Color.errorMessage
        case .IN_MESSAGE: return Color.inMessage
        case .OUT_MESSAGE: return Color.outMessage
        }        
    }
}
