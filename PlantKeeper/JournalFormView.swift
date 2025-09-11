//
//  JournalFormView.swift
//  PlantKeeper
//
//  Created by Ronald on 11/9/2025.
//
import SwiftUI
import PhotosUI

struct JournalFormView: View {
    @Binding var text: String
    @Binding var mood: String
    @Binding var selectedImage: UIImage?
    @Binding var selectedItem: PhotosPickerItem?
    
    var body: some View {
        Form {
            NotesSection(text: $text)
            MoodSection(selectedMood: $mood)
            PhotoSection(
                selectedImage: $selectedImage,
                selectedItem: $selectedItem
            )
        }
    }
}

private struct NotesSection: View {
    @Binding var text: String
    
    var body: some View {
        Section("Notes") {
            TextEditor(text: $text)
                .frame(minHeight: 100, maxHeight: 150)
        }
    }
}
        
private struct MoodSection: View {
    @Binding var selectedMood: String
    private let moods = ["😊", "😢", "🌱", "🌸"]
    
    var body: some View {
        Section("Mood") {
            HStack {
                ForEach(moods, id: \.self) { mood in
                    Button {
                        selectedMood = mood
                    } label: {
                        Text(mood)
                            .font(.largeTitle)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(mood == selectedMood ? Color.blue.opacity(0.3) : .clear)
                            )
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }
            .padding(.vertical, 4)
        }
    }
}

private struct PhotoSection: View {
    @Binding var selectedImage: UIImage?
    @Binding var selectedItem: PhotosPickerItem?
    
    var body: some View {
        Section(header: Text("Photo")) {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
            }
            PhotosPicker("Choose Photo", selection: $selectedItem, matching: .images)
                .onChange(of: selectedItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            selectedImage = uiImage
                        }
                    }
                }
        }
    }
}
