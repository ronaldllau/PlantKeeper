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
}

extension JournalEntry {
    var isFromToday: Bool {
        Calendar.current.isDateInToday(date)
    }
}


