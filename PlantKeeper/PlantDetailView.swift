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
            
            Text("Next watering: \(plant.nextWateringDate, style: .date)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(action: {
                markAsWatered()
            }) {
                Label("Watered Today", systemImage: "drop.fill")
                    .font(.headline)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }


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
    
    func markAsWatered() {
        plant.lastWatered = Date()

        // Reschedule the reminder from today
        scheduleWateringReminder(for: plant, in: plant.wateringFrequency)
    }
    
    func scheduleWateringReminder(for plant: Plant, in days: Int) {
        let center = UNUserNotificationCenter.current()

        // Remove any old reminder for this plant
        center.removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
        
        let content = UNMutableNotificationContent()
        content.title = "Water your plant 🌱"
        content.body = "Don't forget to water \(plant.name)!"
        content.sound = .default

        // Trigger after X days (for now)
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(60 * 60 * 24 * days),
            repeats: true
        )

        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )

        center.add(request)
    }

}
