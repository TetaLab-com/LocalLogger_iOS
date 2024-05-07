// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public class LocalLogger {
    private static let viewModel = LogsViewModel()
    private static let navigation = NavigationManager()
    
    public static func startSession() {
        LogDatabase.shared.startSession()
    }
    
    public static func presentCurrentLogs() {
        guard let presentedVC = UIApplication.shared.keyWindowPresentedController else {
            print("[Error][LocalLogger] presentCurrentLogs: unable to find key window presented controller")
            return
        }
        
        presentedVC.presentSwiftUIView {
            LogsView()
                .environmentObject(viewModel)
                .environmentObject(navigation)
        }
    }
    
    public static func presentLogs() {
        guard let presentedVC = UIApplication.shared.keyWindowPresentedController else {
            print("[Error][LocalLogger] presentLogs: unable to find key window presented controller")
            return
        }
        
        presentedVC.presentSwiftUIView {
            MainView()
                .environmentObject(viewModel)
                .environmentObject(navigation)
        }
    }
    
    public static func w(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        LogDataSource.shared.w(
            className: className,
            methodName: methodName,
            message: message
        )
    }

    public static func i(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        LogDataSource.shared.i(
            className: className,
            methodName: methodName,
            message: message
        )
    }
    
    public static func e(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        LogDataSource.shared.e(
            className: className,
            methodName: methodName,
            message: message
        )
    }
    
    public static func inMessage(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        LogDataSource.shared.inMessage(
            className: className,
            methodName: methodName,
            message: message
        )
    }
    
    public static func outMessage(
        className: String = #file,
        methodName: String = #function,
        message: String
    ) {
        LogDataSource.shared.outMessage(
            className: className,
            methodName: methodName,
            message: message
        )
    }
}
