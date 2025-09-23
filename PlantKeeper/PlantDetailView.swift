//
//  PlantDetailView.swift
//  PlantKeeper
//
//  Created by Ronald on 2/9/2025.
//


import SwiftUI
import SwiftData
import UserNotifications

struct PlantDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var plant: Plant  // Changed to @Bindable for SwiftData
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
                    
        JournalList(plant: plant, editingEntry: $editingEntry)  // Now passes plant directly
                
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showingAddJournal = true }) {
                    Label("Add Journal", systemImage: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showingAddJournal) {
            AddJournalView { entry in
                plant.journals.append(entry)
                try? modelContext.save()
            }
        }
        .sheet(item: $editingEntry) { entry in
            EditJournalView(entry: entry)
        }
    }
    
    func markAsWatered() {
        plant.lastWatered = Date()
        try? modelContext.save()

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
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Plant.self, configurations: config)
    let plant = Plant(name: "Test Plant", species: "Test Species", wateringFrequency: 7)
    container.mainContext.insert(plant)
    return PlantDetailView(plant: plant)
        .modelContainer(container)
}
