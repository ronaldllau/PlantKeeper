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
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: "leaf.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                
                VStack(alignment: .leading) {
                    Text(plant.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(plant.species)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            Divider()
            
            Text("Next watering: \(plant.nextWateringDate, style: .date)")
                .font(.headline)
                .foregroundColor(.blue)
                        
            Button(action: {
                markAsWatered()
            }) {
                Label("Watered Today", systemImage: "drop.fill")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(12)
            }
        }
        .padding()
                    
        JournalList(plant: $plant, editingEntry: $editingEntry)
                
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddJournal = true }) {
                    Label("Add Journal", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showingAddJournal) {
            AddJournalView{ entry in
                plant.journals.append(entry)
            }
        }
        .sheet(item: $editingEntry) { entry in
            if let index = plant.journals.firstIndex(where: { $0.id == entry.id }) {
                EditJournalView(entry: $plant.journals[index])
            }
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

#Preview {
    ContentView()
}
