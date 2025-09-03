//
//  EditJournalView.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//


import SwiftUI

struct EditJournalView: View {
    @Environment(\.dismiss) var dismiss
    let entry: JournalEntry
    @Binding var plant: Plant

    @State private var text: String = ""

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
            .navigationTitle("Edit Journal")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let index = plant.journals.firstIndex(where: { $0.id == entry.id }) {
                            plant.journals[index] = JournalEntry(
                                text: text,
                                date: entry.date // keep original date
                            )
                        }
                        dismiss()
                    }
                    .disabled(text.isEmpty)
                }
            }
        }
        .onAppear {
            text = entry.text
        }
    }
}
