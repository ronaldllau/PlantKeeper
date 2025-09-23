//
//  EditJournalView.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//


import SwiftUI
import PhotosUI
import SwiftData

struct EditJournalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    let entry: JournalEntry
    
    @State private var text: String
    @State private var mood: Mood
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage?
    
    init(entry: JournalEntry) {
        self.entry = entry
        _text = State(initialValue: entry.text)
        _mood = State(initialValue: entry.mood)
        _selectedImage = State(initialValue: entry.photo?.uiImage)
    }
    
    var body: some View {
        VStack {
            JournalFormView(
                text: $text,
                mood: $mood,
                selectedImage: $selectedImage,
                selectedItem: $selectedItem
            )
            
            Button("Save Changes") {
                entry.text = text
                entry.mood = mood
                
                if let newImage = selectedImage {
                    if let existingPhoto = entry.photo {
                        // Update existing photo
                        existingPhoto.uiImage = newImage
                    } else {
                        // Create new photo
                        let photo = JournalPhoto(uiImage: newImage)
                        modelContext.insert(photo)
                        entry.photo = photo
                    }
                }
                
                try? modelContext.save()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}
