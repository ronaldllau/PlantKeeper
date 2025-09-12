//
//  JournalPhoto.swift
//  PlantKeeper
//
//  Created by Ronald on 12/9/2025.
//
import SwiftUI

struct JournalPhoto: Identifiable, Codable {
    var id = UUID()
    var data: Data

    var uiImage: UIImage? {
        UIImage(data: data)
    }

    init(uiImage: UIImage) {
        self.data = uiImage.jpegData(compressionQuality: 0.8) ?? Data()
    }
}
