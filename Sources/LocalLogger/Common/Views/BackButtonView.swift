//
//  BackButtonView.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import SwiftUI

struct BackButton: View {
    let isClose: Bool
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isClose ? "xmark" : "chevron.left")
                .resizable()
                .scaledToFit()
                .fontWeight(.semibold)
                .frame(width: 16, height: 16)
        }
    }
}

#Preview {
    BackButton(isClose: false) {}
}
