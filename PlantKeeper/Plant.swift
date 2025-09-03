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
}
