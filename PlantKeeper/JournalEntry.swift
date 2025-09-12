//
//  JournalEntry.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//

import Foundation
import PhotosUI

struct JournalEntry: Identifiable {
    let id = UUID()
    let date: Date
    var text: String
    var photo: JournalPhoto?    // optional, stores image data
    var mood: Mood             // e.g. "😊", "😢", "🌱"
}

extension JournalEntry {
    var isFromToday: Bool {
        Calendar.current.isDateInToday(date)
    }
}


