//
//  ContentView.swift
//  PlantKeeper
//
//  Created by Ronald on 1/7/2025.
//

import SwiftUI

let samplePlants = [
    Plant(name: "Fern", species: "Boston Fern"),
    Plant(name: "Cactus", species: "Golden Barrel"),
    Plant(name: "Aloe Vera", species: "Aloe")
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
                    VStack(alignment: .leading) {
                        Text(plant.name)
                            .font(.headline)
                        Text(plant.species)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
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
