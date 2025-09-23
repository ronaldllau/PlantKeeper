//
//  EmptyPlantView.swift
//  PlantKeeper
//
//  Created by Ronald on 23/9/2025.
//

import SwiftUI

struct EmptyPlantView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "leaf.circle")
                .font(.system(size: 100))
                .foregroundColor(.green)
            
            Text("Add your adorable plant to get started!")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
