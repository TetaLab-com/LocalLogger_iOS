//
//  SessionCellView.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import SwiftUI

struct SessionCellView: View {
    let session: Session
    let index: Int
    
    var body: some View {
        HStack(spacing: 28) {
            Group {
                Text(session.date.sessionDateFormat()) +
                Text(" ") +
                Text(session.logs.count.description)
            }
            .foregroundStyle(Color.primary)
            
            Spacer()
            
            ShareLink(item: session.logs.getShareString()) {
                Image("shareIcon", bundle: .module)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(Color.purpleMain)
                    .frame(width: 24, height: 24)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .padding(.horizontal, 20)
        .background(index % 2 == 0 ? Color.purpleBackground : Color.purpleSecondary)
        .font(.roboto400, size: 20)
    }
}

#Preview {
    SessionCellView(
        session: .init(date: Date(), logs: []),
        index: 0
    )
}
