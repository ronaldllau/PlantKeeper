//
//  AddPlantView.swift
//  PlantKeeper
//
//  Created by Ronald on 3/9/2025.
//


import SwiftUI

struct AddPlantView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var plants: [Plant]

    @State private var name = ""
    @State private var species = ""
    @State private var wateringFrequency = 2

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Plant Details")) {
                    TextField("Name", text: $name)
                    TextField("Species", text: $species)
                }
                Section(header: Text("Watering Frequency")) {
                    Stepper("\(wateringFrequency) days", value: $wateringFrequency, in: 1...30)
                }
            }
            .navigationTitle("Add Plant")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newPlant = Plant(
                            name: name,
                            species: species,
                            wateringFrequency: wateringFrequency
                        )
                        plants.append(newPlant)

                        scheduleWateringReminder(for: newPlant, in: wateringFrequency) // remind in 2 days
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty || species.isEmpty)
                }
            }
        }
    }
    
    func scheduleWateringReminder(for plant: Plant, in days: Int) {
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

        UNUserNotificationCenter.current().add(request)
    }

}
