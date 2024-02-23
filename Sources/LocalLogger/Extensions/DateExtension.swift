//
//  DateExtension.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import Foundation

extension Date {
    func sessionDateFormat() -> String {
        let dateFormatter = DateFormatter.getFormatter(with: "dd.MM.yyyy HH:mm:ss")
        
        return dateFormatter.string(from: self)
    }
    
    func logDateFormat() -> String {
        let dateFormatter = DateFormatter.getFormatter(with: "mm:ss.SSSS")
        
        return dateFormatter.string(from: self)
    }
}

extension DateFormatter {
    static var cachedFormatters = [String: DateFormatter]()
    
    static func getFormatter(with format: String) -> DateFormatter {
        if let formatter = cachedFormatters[format] {
            return formatter
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        
        cachedFormatters[format] = dateFormatter
        
        return dateFormatter
    }
}
