//
//  FirebaseProfileSwiftUIApp.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 14/9/21.
//

import SwiftUI
import Firebase

@main
struct FirebaseProfileSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
