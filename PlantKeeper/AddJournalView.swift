//
//  AddJournalView.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//


import SwiftUI

struct AddJournalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var plant: Plant

    @State private var text = ""

    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)
                    .padding()
                    .border(Color.gray.opacity(0.3), width: 1)
                    .cornerRadius(8)
                    .frame(minHeight: 200)

                Spacer()
            }
            .navigationTitle("New Journal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if !text.isEmpty {
                            let entry = JournalEntry(text: text, date: Date())
                            plant.journals.append(entry)
                        }
                        dismiss()
                    }
                    .disabled(text.isEmpty)
                }
            }
        }
    }
}
