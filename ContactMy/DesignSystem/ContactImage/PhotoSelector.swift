//
//  PhotoSelector.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import PhotosUI
import Foundation

@MainActor
class PhotoSelector: ObservableObject {
  @Published var selectedImage: UIImage?
  @Published var imageStorage: PhotosPickerItem? {
    didSet {
      setImage(from: imageStorage)
    }
  }
  
  private func setImage(from selection: PhotosPickerItem?) {
    guard let selection else { return }
    
    Task {
      if let data = try? await selection.loadTransferable(type: Data.self) {
        if let uiImage = UIImage(data: data) {
          selectedImage = uiImage
          return
        }
      }
    }
  }
}
