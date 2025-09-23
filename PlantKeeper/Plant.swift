//
//  Plant.swift
//  PlantKeeper
//
//  Created by Ronald on 1/7/2025.
//

import Foundation
import SwiftData

@Model
final class Plant {
    var id: UUID
    var name: String
    var species: String
    @Relationship(deleteRule: .cascade) var journals: [JournalEntry]
    var wateringFrequency: Int // in days
    var lastWatered: Date
    
    init(name: String, species: String, wateringFrequency: Int) {
        self.id = UUID()
        self.name = name
        self.species = species
        self.journals = []
        self.wateringFrequency = wateringFrequency
        self.lastWatered = Date()
    }
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
