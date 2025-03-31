//
//  StreetwearHubApp.swift
//  StreetwearHub
//
//  Created by Venzislav on 17.03.25.
//

import SwiftUI
import SwiftData

@main
struct StreetwearHubApp: App {
    @StateObject private var cartManager = CartManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartManager)
                .preferredColorScheme(.light)
        }
    }
}
