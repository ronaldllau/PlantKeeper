//
//  PlantKeeperApp.swift
//  PlantKeeper
//
//  Created by Ronald on 1/7/2025.
//

import SwiftUI
import UserNotifications

@main
struct PlantKeeperApp: App {
    
    init() {
        requestNotificationPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("✅ Notifications allowed")
                } else {
                    print("❌ Notifications not allowed")
                }
            }
    }
}
