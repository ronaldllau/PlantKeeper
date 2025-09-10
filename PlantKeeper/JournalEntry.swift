//
//  JournalEntry.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//

import Foundation

struct JournalEntry: Identifiable {
    let id = UUID()
    let text: String
    let date: Date
    var photo: Data?   // optional, stores image data
    var mood: String?  // optional, e.g. "😊", "😢", "🌱"
}

extension JournalEntry {
    var isFromToday: Bool {
        Calendar.current.isDateInToday(date)
    }
}


