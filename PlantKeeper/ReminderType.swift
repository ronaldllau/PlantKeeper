//
//  ReminderType.swift
//  PlantKeeper
//
//  Created by Ronald on 9/9/2025.
//


enum ReminderType: String, CaseIterable, Identifiable, Codable {
    case watering = "Watering"
    case fertilizing = "Fertilizing"
    case pruning = "Pruning"
    case repotting = "Repotting"

    var id: String { rawValue }
    var icon: String {
        switch self {
        case .watering: return "drop.fill"
        case .fertilizing: return "leaf.fill"
        case .pruning: return "scissors"
        case .repotting: return "tray.fill"
        }
    }
}
