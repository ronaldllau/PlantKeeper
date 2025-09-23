//
//  JournalEntry.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//

import Foundation
import PhotosUI
import SwiftData

@Model
final class JournalEntry {
    var id: UUID
    var date: Date
    var text: String
    var photo: JournalPhoto?
    var mood: Mood
    
    init(date: Date = Date(), text: String, photo: JournalPhoto? = nil, mood: Mood) {
        self.id = UUID()
        self.date = date
        self.text = text
        self.photo = photo
        self.mood = mood
    }
}

extension JournalEntry {
    var isFromToday: Bool {
        Calendar.current.isDateInToday(date)
    }
}
