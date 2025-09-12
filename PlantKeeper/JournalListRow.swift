//
//  JournalEntryRow.swift
//  PlantKeeper
//
//  Created by Ronald on 10/9/2025.
//
import SwiftUI

struct JournalListRow: View {
    let entry: JournalEntry
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            //                        Text(entry.text)
            //                            .font(.body)
            HStack {
                if entry.isFromToday {
                    Text("Today")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text(entry.date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                
                Text(entry.mood.rawValue)
                    .padding(6)
                    .background(Circle().fill(entry.mood.color.opacity(0.2)))
                    .offset(x: -8, y: 8)
            }
            
            Text(entry.text)
            
            if let image = entry.photo?.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 6)
    }
}
