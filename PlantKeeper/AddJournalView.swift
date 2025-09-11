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
    @State private var mood = "😊"
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
        
    var onSave: (JournalEntry) -> Void

//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Notes")) {
//                    TextEditor(text: $text)
//                        .frame(minHeight: 100, maxHeight: 150)
//                        .scrollContentBackground(.hidden)
//                }
//                
//                Section(header: Text("Mood")) {
//                    Picker("Mood", selection: $mood) {
//                        Text("😊").tag("😊")
//                        Text("😢").tag("😢")
//                        Text("🌱").tag("🌱")
//                        Text("🌸").tag("🌸")
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                }
//                
//                Section(header: Text("Photo")) {
//                    if let image = selectedImage {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
//                    PhotosPicker("Add Photo",
//                                 selection: $selectedItem,
//                                 matching: .images)
//                    .onChange(of: selectedItem) { _, newItem in
//                        Task {
//                            if let data = try? await newItem?.loadTransferable(type: Data.self),
//                               let uiImage = UIImage(data: data) {
//                                selectedImage = uiImage
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationTitle("New Journal")
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                }
//                ToolbarItem(placement: .confirmationAction) {
//                    Button("Save") {
//                        let entry = JournalEntry(
//                            text: text,
//                            date: Date(),
//                            photo: selectedImage?.jpegData(compressionQuality: 0.8),
//                            mood: mood
//                        )
//                        onSave(entry)
//                        dismiss()
//                    }
//                    .disabled(text.isEmpty)
//                }
//            }
//        }
//    }
    
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
                        photo: selectedImage?.jpegData(compressionQuality: 0.8),
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
