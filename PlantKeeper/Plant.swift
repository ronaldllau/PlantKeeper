//
//  Plant.swift
//  PlantKeeper
//
//  Created by Ronald on 1/7/2025.
//

import Foundation

struct Plant: Identifiable {
    let id = UUID()
    let name: String
    let species: String
    
    var journals: [JournalEntry] = []
    var wateringFrequency: Int // in days
    var lastWatered: Date = Date()
}

extension Plant {
    var nextWateringDate: Date {
        Calendar.current.date(
            byAdding: .day,
            value: wateringFrequency,
            to: lastWatered
        ) ?? Date()
    }
    var isOverdue: Bool {
            Date() > nextWateringDate
        }
}
