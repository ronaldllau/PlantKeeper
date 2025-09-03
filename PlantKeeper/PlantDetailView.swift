//
//  PlantDetailView.swift
//  PlantKeeper
//
//  Created by Ronald on 2/9/2025.
//


import SwiftUI

struct PlantDetailView: View {
    @Binding var plant: Plant
    @State private var showingAddJournal = false
    @State private var editingEntry: JournalEntry?

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "leaf.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)

            Text(plant.name)
                .font(.largeTitle)
                .padding(.top)

            Text(plant.species)
                .font(.title3)
                .foregroundColor(.secondary)

            Spacer()
        }
        .padding()
        
        Divider()

        List {
            if plant.journals.isEmpty {
                Text("No journal entries yet.")
                    .foregroundColor(.secondary)
            } else {
                ForEach(plant.journals) { entry in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(entry.text)
                        if entry.isFromToday {
                            Text("Today")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        } else {
                            Text(entry.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                    .swipeActions(edge: .leading) {
                        if entry.isFromToday {
                            Button {
                                editingEntry = entry
                            } label: {
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
        .navigationTitle(plant.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddJournal = true }) {
                    Label("Add Journal", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showingAddJournal) {
            AddJournalView(plant: $plant)
        }
        .sheet(item: $editingEntry) { entry in
            EditJournalView(entry: entry, plant: $plant)
        }
    }
    
    func deleteEntry(_ entry: JournalEntry) {
        if let index = plant.journals.firstIndex(where: { $0.id == entry.id }) {
            plant.journals.remove(at: index)
        }
    }
}
