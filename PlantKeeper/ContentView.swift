//
//  ContentView.swift
//  PlantKeeper
//
//  Created by Ronald on 1/7/2025.
//

import SwiftUI
import SwiftData

//let samplePlants = [
//    Plant(name: "Fern", species: "Boston Fern", wateringFrequency: 3),
//    Plant(name: "Cactus", species: "Golden Barrel", wateringFrequency: 5),
//    Plant(name: "Aloe Vera", species: "Aloe", wateringFrequency: 10)
//]
//
//let sampleJournal = [
//    JournalEntry(date: Date().addingTimeInterval(-86400 * 5), text: "Planted the fern.", mood: Mood.plant),
//    JournalEntry(date: Date(), text: "Watered the fern.", mood: Mood.flower)
//    
//]

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var plants: [Plant]
    @State private var showingAddPlant = false
    
    var body: some View {
        
        NavigationView {
            if plants.isEmpty {
                EmptyPlantView()
                    .toolbar {
                        Button(action: { showingAddPlant = true }) {
                            Label("Add Plant", systemImage: "plus")
                        }
                    }
                    .sheet(isPresented: $showingAddPlant) {
                        AddPlantView()
                    }
            } else {
                List(plants) { plant in
                    NavigationLink(destination: PlantDetailView(plant: plant)) {
                        HStack {
                            Image(systemName: "leaf.fill")
                                .foregroundColor(.green)
                                .frame(width: 30, height: 30)
                            
                            VStack(alignment: .leading) {
                                Text(plant.name)
                                    .font(.headline)
                                Text(plant.species)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Text(plant.isOverdue ? "🚨 Overdue" :"💧 \(plant.wateringFrequency)d")
                                .font(.caption)
                                .foregroundColor(plant.isOverdue ? .red : .blue)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .navigationTitle("My Plants")
                .toolbar {
                    Button(action: { showingAddPlant = true }) {
                        Label("Add Plant", systemImage: "plus")
                    }
                }
                .sheet(isPresented: $showingAddPlant) {
                    AddPlantView()
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Plant.self, configurations: config)
    let plant = Plant(name: "Test Plant", species: "Test Species", wateringFrequency: 7)
    container.mainContext.insert(plant)
    return ContentView()
        .modelContainer(container)
}
