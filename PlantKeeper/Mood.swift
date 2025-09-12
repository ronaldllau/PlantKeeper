//
//  Mood.swift
//  PlantKeeper
//
//  Created by Ronald on 12/9/2025.
//
import SwiftUI

enum Mood: String, CaseIterable, Identifiable, Codable {
    case happy = "😊"
    case sad = "😢"
    case excited = "🥳"
    case plant = "🌱"
    case flower = "🌸"
    
    var id: String { rawValue }

    var description: String {
        switch self {
        case .happy: "Happy"
        case .sad: "Sad"
        case .excited: "Excited"
        case .plant: "Plant"
        case .flower: "Flower"
        }
    }

    var color: Color {
        switch self {
        case .happy: .yellow
        case .sad: .blue
        case .excited: .orange
        case .plant: .green
        case .flower: .pink
        }
    }
}
