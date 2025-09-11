//
//  EmptyJournalView.swift
//  PlantKeeper
//
//  Created by Ronald on 10/9/2025.
//
import SwiftUI

struct EmptyJournalView: View {
    let plantName: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "rainbow")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("Start \(plantName)’s journey")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
