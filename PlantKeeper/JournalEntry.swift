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
    var photo: Data?    // optional, stores image data
    var mood: String    // e.g. "😊", "😢", "🌱"
}

extension JournalEntry {
    var isFromToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var uiImage: UIImage? {
        get {
            if let data = photo {
                return UIImage(data: data)
            }
            return nil
        }
        set {
            photo = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
}


