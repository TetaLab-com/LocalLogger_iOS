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
        HStack {
            Text(log.dateTime.logDateFormat())
                //.foregroundStyle(colorScheme == .light ? Color.textGray : Color.white)
            
            Spacer(minLength: 0)
            
            Text(log.level.getLevelPrefix() + log.message)
                .foregroundStyle(log.level.getColor())
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .padding(.horizontal, 20)
        //.background(index % 2 == 1 ? Color.purpleBackground : Color.purpleSecondary)
        .font(.roboto400, size: 20)
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
