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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Title.self)
    }
}
