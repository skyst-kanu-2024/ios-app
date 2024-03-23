//
//  kanutestApp.swift
//  kanutest
//
//  Created by Soongyu Kwon on 3/24/24.
//

import SwiftUI
import GoogleSignIn

@main
struct kanutestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        // Check if `user` exists; otherwise, do something with `error`
                    }
                }
        }
    }
}
