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
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(entry.date, style: .date)
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                
//                Spacer()
//                
//                if entry.isFromToday {
//                    Image(systemName: "clock")
//                        .foregroundColor(.blue)
//                }
//            }
//            
//            Text(entry.text)
//                .font(.body)
//                .lineLimit(3)
//        }
//        .padding(.vertical, 4)
        
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
                
                
                Text(entry.mood)
                    .padding(6)
                    .background(Circle().fill(Color(.systemGray6)))
                    .offset(x: -8, y: 8)
            }
            
            Text(entry.text)
            
            if let data = entry.photo,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 6)
        
//        ZStack(alignment: .topTrailing) {
//            VStack(alignment: .leading, spacing: 8) {
//                if let data = entry.photo,
//                   let uiImage = UIImage(data: data) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 120)
//                        .cornerRadius(8)
//                }
//
//                Text(entry.text)
//                    .font(.body)
//                    .lineLimit(nil)
//
//                Text(entry.date, style: .date)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
//            .padding()
//            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemBackground)))
//            .shadow(radius: 2)
//
//            // ✅ Mood emoji badge
//            if let mood = entry.mood {
//                Text(mood)
//                    .font(.largeTitle)
//                    .padding(6)
//                    .background(Circle().fill(Color.white.opacity(0.8)))
//                    .offset(x: -8, y: 8)
//            }
//        }
    }
}
