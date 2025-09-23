//
//  PlantJournalList.swift
//  PlantKeeper
//
//  Created by Ronald on 10/9/2025.
//
import SwiftUI
import SwiftData

struct JournalList: View {
    let plant: Plant  // Changed from @Binding to let since we're using SwiftData
    @Binding var editingEntry: JournalEntry?
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        List {
            if plant.journals.isEmpty {
                EmptyJournalView(plantName: plant.name)
            } else {
                ForEach(plant.journals) { entry in
                    JournalListRow(entry: entry)
                        .swipeActions(edge: .leading) {
                            if entry.isFromToday {
                                Button { editingEntry = entry } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            if entry.isFromToday {
                                Button(role: .destructive) {
                                    deleteEntry(entry)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                }
            }
        }
    }
    
    private func deleteEntry(_ entry: JournalEntry) {
        if let index = plant.journals.firstIndex(where: { $0.id == entry.id }) {
            plant.journals.remove(at: index)
            modelContext.delete(entry)
        }
    }
}
