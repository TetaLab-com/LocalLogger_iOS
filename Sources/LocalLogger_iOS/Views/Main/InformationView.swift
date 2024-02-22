//
//  InformationView.swift
//  LocalLogger
//
//  Created by Dmytro Savka
//

import SwiftUI

struct InformationView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            xmarkButton
            dataStorageText
            thanksText
                .padding(.top, 10)
            infoImage
                .padding(.vertical)
            securityText
            weTakeText
            okButton
                .padding(.vertical)
        }
        .padding()
        //.background(Color.purpleBackground)
    }
    
    private var xmarkButton: some View {
        Button {
            showAlert = false
        } label: {
            Image(systemName: "xmark")
                .frame(width: 24, height: 24)
                .fontWeight(.semibold)
                //.foregroundStyle(Color.purpleGray)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var dataStorageText: some View {
        Text("Data storage")
            .font(.roboto700, size: 16)
    }
    
    private var thanksText: some View {
        Text("Thank you for choosing our Logger Library! We want to inform you that library collect developer logs and store them locally. You are able to inform developers about application issues and provide important logs to understands what’s happened.")
            .font(.roboto400, size: 16)
            .multilineTextAlignment(.center)
    }
    
    private var infoImage: some View {
        Image("infoImage")
            .resizable()
            .scaledToFit()
            .frame(width: 160, height: 160)
    }
    
    private var securityText: some View {
        Text("Your Security — Our Priority")
            .font(.roboto700, size: 16)
    }
    
    private var weTakeText: some View {
        Text("We take all necessary measures to ensure the security of the collected data. These logs stay only on your device and are not sent anywhere. They are used solely to improve the product and ensure the app's quality performance priority.")
            .font(.roboto400, size: 16)
            .multilineTextAlignment(.center)
    }
    
    private var okButton: some View {
        Button {
            showAlert = false
            navigationManager.selectedTab = navigationManager.previouslySelectedTab
        } label: {
            Text("Ok")
                .font(.roboto700, size: 16)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        //.fill(Color.purpleButton)
                )
        }
    }
}

#Preview {
    InformationView(showAlert: .constant(true))
        .environmentObject(NavigationManager())
}
