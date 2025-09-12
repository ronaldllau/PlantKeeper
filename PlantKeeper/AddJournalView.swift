//
//  AddJournalView.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//


import SwiftUI
import PhotosUI

struct AddJournalView: View {
    @Environment(\.dismiss) var dismiss
    
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
                    let newEntry = JournalEntry(
                        date: Date(),
                        text: text,
                        photo: selectedImage.map { JournalPhoto(uiImage: $0) },
                        mood: mood
                    )
                    onSave(newEntry)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
}
