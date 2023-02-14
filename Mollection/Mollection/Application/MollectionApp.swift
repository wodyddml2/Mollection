//
//  MollectionApp.swift
//  Mollection
//
//  Created by J on 2023/02/09.
//

import SwiftUI
import Firebase

@main
struct MollectionApp: App {
    
    @StateObject var firestoreManager = FBStore()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(firestoreManager)
        }
    }
}
