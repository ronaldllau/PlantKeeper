//
//  JournalPhoto.swift
//  PlantKeeper
//
//  Created by Ronald on 12/9/2025.
//
import SwiftUI
import SwiftData

@Model
final class JournalPhoto {
    var id: UUID
    var data: Data
    
    var uiImage: UIImage? {
        get {
            UIImage(data: data)
        }
        set {
            if let newImage = newValue {
                data = newImage.jpegData(compressionQuality: 0.8) ?? Data()
            }
        }
    }
    
    init(uiImage: UIImage) {
        self.id = UUID()
        self.data = uiImage.jpegData(compressionQuality: 0.8) ?? Data()
    }
}
