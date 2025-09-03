//
//  ContentView.swift
//  PlantKeeper
//
//  Created by Ronald on 1/7/2025.
//

import SwiftUI

let samplePlants = [
    Plant(name: "Fern", species: "Boston Fern", wateringFrequency: 3),
    Plant(name: "Cactus", species: "Golden Barrel", wateringFrequency: 5),
    Plant(name: "Aloe Vera", species: "Aloe", wateringFrequency: 10)
]

struct ContentView: View {
    
    @State private var plants = samplePlants
    @State private var showingAddPlant = false
    
    var body: some View {
//        VStack {
//            HStack {
//                Image(systemName: "leaf.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 40, height: 40)
//                    .foregroundColor(.green)
//
//                Text("Hello, Plant Keeper 🌱")
//                    .font(.title)
//            }
//
//            Text("Remember to water your plants 💧")
//                .font(.subheadline)
//        }
//        .padding()

        NavigationView {
            List($plants) { $plant in
                NavigationLink(destination: PlantDetailView(plant: $plant)) {
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
                        
                        Text("💧 \(plant.wateringFrequency)d")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("My Plants")
            .toolbar {
                Button(action: { showingAddPlant = true }) {
                    Label("Add Plant", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingAddPlant) {
                AddPlantView(plants: $plants)
            }
        }
    }
}

#Preview {
    ContentView()
}
