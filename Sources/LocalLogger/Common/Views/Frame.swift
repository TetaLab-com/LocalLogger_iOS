//
//  Frame.swift
//  LocalLogger
//
//  Created by Ruslan Duda on 22.02.2024.
//

import SwiftUI

struct Frame: View {
    var height: CGFloat = 0
    var width: CGFloat = 0
    
    var body: some View {
        ZStack{}.frame(width: width, height: height)
    }
}

#Preview {
    Frame()
}
