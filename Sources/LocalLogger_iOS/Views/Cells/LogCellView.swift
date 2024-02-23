//
//  LogCellView.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import SwiftUI

struct LogCellView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let log: Log
    let index: Int
    
    var body: some View {
        HStack(spacing: 12) {
            Text(log.dateTime.logDateFormat())
                .foregroundStyle(colorScheme == .light ? Color.textGray : Color.white)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(log.getUserMessage())
                .foregroundStyle(log.level.foregroundColor)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(index % 2 == 1 ? Color.purpleBackground : Color.purpleSecondary)
        .font(.roboto400, size: 14)
    }
}

#Preview {
    LogCellView(
        log: Log(
            dateTime: Date(),
            message: "Hello",
            level: .error,
            className: "Hello",
            methodName: "World"
        ),
        index: 0
    )
}
