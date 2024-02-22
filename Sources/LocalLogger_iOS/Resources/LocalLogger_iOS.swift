// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public class LocalLogger {
    private static let viewModel = LogsViewModel()
    
    public static func startSession() {
        LogDatabase.shared.startSession()
    }
    
    public static func present() {
        guard let presentedVC = UIApplication.shared.keyWindowPresentedController else {
            print("[Error][LocalLogger] present: unable to find key window presented controller")
            return
        }
        
        presentedVC.presentSwiftUIView {
            LogsView()
                .environmentObject(viewModel)
        }
    }
    
    public static func presentAllLogs() {
        
    }
    
    public static func w(
        className: String = "",
        methodName: String = "",
        message: String
    ) {
        LogDataSource.shared.w(
            className: className,
            methodName: methodName,
            message: message
        )
    }

    public static func i(
        className: String = "",
        methodName: String = "",
        message: String
    ) {
        LogDataSource.shared.i(
            className: className,
            methodName: methodName,
            message: message
        )
    }
    
    public static func e(
        className: String = "",
        methodName: String = "",
        message: String
    ) {
        LogDataSource.shared.e(
            className: className,
            methodName: methodName,
            message: message
        )
    }
    
    public static func inMessage(
        className: String = "",
        methodName: String = "",
        message: String
    ) {
        LogDataSource.shared.inMessage(
            className: className,
            methodName: methodName,
            message: message
        )
    }
    
    public static func outMessage(
        className: String = "",
        methodName: String = "",
        message: String
    ) {
        LogDataSource.shared.outMessage(
            className: className,
            methodName: methodName,
            message: message
        )
    }
}

extension UIViewController {
    func presentSwiftUIView<Content: View>(@ViewBuilder _ switfUIView: () -> Content) {
        let vc = UIHostingController(rootView: switfUIView())

        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        
        present(vc, animated: true)
    }
    
    static func swiftUIViewController<Content: View>(_ content: Content) -> UIViewController {
        UIHostingController(rootView: content)
    }
}
