//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by MacMini on 11/12/25.
//

import SwiftUI
import SwiftData
@main
struct MovieAppApp: App {
    @StateObject private var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
          // SplashView()
           // ContentView()
            if authManager.isAuthenticated {
                            TabView2()
                                .environmentObject(authManager) // Pass it down
                        } else {
                            SplashView()
                                .environmentObject(authManager) // Pass it down
                        }
        }
        .modelContainer(for: Title.self)
    }
}

