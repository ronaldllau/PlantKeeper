//
//  EditJournalView.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//


import SwiftUI
import PhotosUI

struct EditJournalView: View {
    @Binding var entry: JournalEntry
    @Environment(\.dismiss) private var dismiss
    @State private var text: String
    @State private var mood: String
    @State private var selectedImage: UIImage?
    @State private var selectedItem: PhotosPickerItem?
    
    init(entry: Binding<JournalEntry>) {
        _entry = entry
        _text = State(initialValue: entry.wrappedValue.text)
        _mood = State(initialValue: entry.wrappedValue.mood)
        _selectedImage = State(initialValue: entry.wrappedValue.uiImage)
    }
    
    var body: some View {
        VStack {
            JournalFormView(text: $text,
                            mood: $mood,
                            selectedImage: $selectedImage,
                            selectedItem: $selectedItem)
            
            Button("Save") {
                entry.text = text
                entry.mood = mood
                entry.uiImage = selectedImage
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}
