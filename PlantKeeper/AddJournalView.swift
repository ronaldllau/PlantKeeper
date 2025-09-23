//
//  AddJournalView.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//


import SwiftUI
import PhotosUI
import SwiftData

struct AddJournalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var text = ""
    @State private var mood = Mood.happy
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
        
    var onSave: (JournalEntry) -> Void
    
    var body: some View {
        VStack {
            JournalFormView(text: $text,
                          mood: $mood,
                          selectedImage: $selectedImage,
                          selectedItem: $selectedItem)

            Button("Save") {
                let photo = selectedImage.map { JournalPhoto(uiImage: $0) }
                if let photo = photo {
                    modelContext.insert(photo)
                }
                
                let newEntry = JournalEntry(
                    date: Date(),
                    text: text,
                    photo: photo,
                    mood: mood
                )
                modelContext.insert(newEntry)
                onSave(newEntry)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}
