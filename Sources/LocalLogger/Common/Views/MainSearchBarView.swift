//
//  MainSearchBarView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct MainSearchBarView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @Binding var searchText: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack {
            magIcon
            textField
                .padding(.leading, 30)
            xmark
        }
        .frame(height: 56)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.purpleSecondary)
        )
        .onTapGesture {
            isFocused = true
        }
    }
    
    var textField: some View {
        TextField("Search", text: $searchText)
            .focused($isFocused)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
    
    var magIcon: some View {
        Image(systemName: "magnifyingglass")
            .frame(width: 24, height: 24)
            .fontWeight(.semibold)
            .foregroundStyle(colorScheme == .light ? Color.purpleMain : Color.white )
    }
    
    var xmark: some View {
        Button {
            isFocused = false
            searchText = ""
        } label: {
            Image(systemName: "xmark")
                .frame(width: 24, height: 24)
                .fontWeight(.semibold)
                .foregroundStyle(colorScheme == .light ? Color.purpleMain : Color.white )
        }
    }
}

#Preview {
    MainSearchBarView(searchText: .constant(""))
        .padding(.horizontal)
}
